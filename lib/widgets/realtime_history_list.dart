import 'package:flutter/material.dart';

class HistoryEvent {
  final DateTime at;
  final String label; // ex: "Start", "Pause", "Stop"
  final Duration? duration; // optionnel

  HistoryEvent({required this.at, required this.label, this.duration});
}

class RealtimeHistoryList extends StatelessWidget {
  const RealtimeHistoryList({
    super.key,
    required this.stream, // Stream<List<HistoryEvent>>
    this.title = "Historique (temps réel)",
  });

  final Stream<List<HistoryEvent>> stream;
  final String title;

  String _ago(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1) return 'à l’instant';
    if (diff.inMinutes < 60) return 'il y a ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'il y a ${diff.inHours} h';
    return '${d.day}/${d.month} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            StreamBuilder<List<HistoryEvent>>(
              stream: stream,
              builder: (context, snap) {
                final items = snap.data ?? const <HistoryEvent>[];
                if (items.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Aucun évènement pour le moment',
                        style: Theme.of(context).textTheme.bodySmall),
                  );
                }
                return ListView.separated(
                  itemCount: items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final e = items[i];
                    return ListTile(
                      leading: switch (e.label) {
                        'Start' => const Icon(Icons.play_arrow_rounded),
                        'Pause' => const Icon(Icons.pause_rounded),
                        'Stop' => const Icon(Icons.stop_rounded),
                        _ => const Icon(Icons.fiber_manual_record, size: 16),
                      },
                      title: Text(e.label),
                      subtitle: e.duration == null
                          ? null
                          : Text('Durée: ${e.duration!.inMinutes} min'),
                      trailing: Text(_ago(e.at),
                          style: Theme.of(context).textTheme.bodySmall),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
