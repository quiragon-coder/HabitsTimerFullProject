import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../activities/domain/activity.dart';
import '../../../core/time_utils.dart';
import '../../timer/application/active_timer_controller.dart';
import '../../sessions/application/history_provider.dart';

class ActivityDetailScreen extends ConsumerWidget {
  final Activity activity;
  const ActivityDetailScreen({super.key, required this.activity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(activeTimerControllerProvider(activity.id));
    final ctrl = ref.read(activeTimerControllerProvider(activity.id).notifier);
    final historyAsync = ref.watch(sessionHistoryProvider(activity.id));

    return Scaffold(
      appBar: AppBar(title: Text('${activity.emoji} ${activity.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Center(
              child: Text(
                formatHhMmSs(timer.elapsed),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (timer.state == TimerRunState.idle) ...[
                  _Btn(icon: Icons.play_arrow, label: 'Lancer', onTap: ctrl.play, busy: timer.isBusy),
                ] else if (timer.state == TimerRunState.running) ...[
                  _Btn(icon: Icons.pause, label: 'Pause', onTap: ctrl.pause, busy: timer.isBusy),
                  const SizedBox(width: 12),
                  _Btn(icon: Icons.stop, label: 'Stop', onTap: ctrl.stop, busy: timer.isBusy),
                ] else if (timer.state == TimerRunState.paused) ...[
                  _Btn(icon: Icons.play_arrow, label: 'Reprendre', onTap: ctrl.resume, busy: timer.isBusy),
                  const SizedBox(width: 12),
                  _Btn(icon: Icons.stop, label: 'Stop', onTap: ctrl.stop, busy: timer.isBusy),
                ],
              ],
            ),
            const SizedBox(height: 16),
            if (timer.error != null)
              Text(timer.error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),
            const Text('Historique', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Expanded(
              child: historyAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return const Text('Aucune session pour le moment.');
                  }
                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final it = items[index];
                      final end = it.end ?? DateTime.now();
                      final line = '${formatHm(it.start)} → ${formatHm(end)} (${formatDurationShort(it.netDuration)})';
                      return _HistoryItem(text: line);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Text('Erreur: $e'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool busy;
  const _Btn({required this.icon, required this.label, required this.onTap, required this.busy});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: busy ? null : onTap,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String text;
  const _HistoryItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Icon(Icons.history, size: 18),
          const SizedBox(width: 8),
          Flexible(child: Text(text)),
        ],
      ),
    );
  }
}
