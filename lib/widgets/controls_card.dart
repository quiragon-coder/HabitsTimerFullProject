import 'package:flutter/material.dart';

class ControlsCard extends StatelessWidget {
  const ControlsCard({
    super.key,
    required this.isRunning,
    required this.onStart,
    required this.onPause,
    required this.onStop,
    this.ticker, // Stream<Duration> pour le badge (temps écoulé)
    this.elapsed, // valeur statique si pas de stream
    this.title = 'Contrôles',
  });

  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onStop;
  final Stream<Duration>? ticker;
  final Duration? elapsed;
  final String title;

  String _fmt(Duration d) {
    final h = d.inHours.remainder(100).toString().padLeft(2, '0');
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final badge = Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer_outlined, size: 16),
          const SizedBox(width: 6),
          StreamBuilder<Duration>(
            stream: ticker,
            builder: (context, snap) {
              final d = snap.data ?? elapsed ?? Duration.zero;
              return Text(
                _fmt(d),
                style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()]),
              );
            },
          ),
        ],
      ),
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 12,
              spacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                badge,
                FilledButton.tonalIcon(
                  onPressed: isRunning ? null : onStart,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Start'),
                ),
                FilledButton.icon(
                  onPressed: isRunning ? onPause : null,
                  icon: const Icon(Icons.pause_rounded),
                  label: const Text('Pause'),
                ),
                FilledButton.tonalIcon(
                  onPressed: onStop,
                  icon: const Icon(Icons.stop_rounded),
                  label: const Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
