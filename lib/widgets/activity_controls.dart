import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../providers_timer.dart';

class ActivityControls extends ConsumerWidget {
  const ActivityControls({
    super.key,
    required this.activityId,
  });

  final dynamic activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRunning = ref.watch(isRunningProvider(activityId));
    final isPaused  = ref.watch(isPausedProvider(activityId));

    return Row(
      children: [
        // Pause / Reprendre
        FilledButton.icon(
          onPressed: () async {
            await ref.read(dbProvider).togglePause(activityId);
          },
          icon: const Icon(Icons.pause),
          label: isPaused.when(
            data: (p) => Text(p ? 'Reprendre' : 'Pause'),
            loading: () => const Text('...'),
            error: (_, __) => const Text('Pause'),
          ),
        ),
        const SizedBox(width: 12),
        // Arrêter
        OutlinedButton.icon(
          onPressed: () async {
            await ref.read(dbProvider).stop(activityId);
          },
          icon: const Icon(Icons.stop),
          label: const Text('Arrêter'),
        ),
        const Spacer(),
        // Badge temps écoulé
        isRunning.when(
          data: (running) {
            if (!running) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _LiveElapsed(activityId: activityId),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _LiveElapsed extends ConsumerWidget {
  const _LiveElapsed({required this.activityId});
  final dynamic activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elapsed = ref.watch(runningElapsedProvider(activityId));
    return elapsed.when(
      data: (d) => Text(_fmt(d),
          style: Theme.of(context).textTheme.labelLarge),
      loading: () => const Text('00:00'),
      error: (e, _) => Text('—', style: TextStyle(color: Colors.red.shade300)),
    );
  }

  String _fmt(Duration d) {
    final mm = (d.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (d.inSeconds % 60).toString().padLeft(2, '0');
    final hh = d.inHours;
    return hh > 0 ? '$hh:$mm:$ss' : '$mm:$ss';
  }
}
