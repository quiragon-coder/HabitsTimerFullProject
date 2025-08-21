import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers_timer.dart';

class ElapsedBadge extends ConsumerWidget {
  const ElapsedBadge({super.key, required this.activityId});
  final int activityId;

  String _fmt(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) return '${h}h ${m}m ${s}s';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = activityId.toString();
    final elapsed = ref.watch(elapsedStreamProvider(uid)).maybeWhen(
      data: (d) => d, orElse: () => Duration.zero,
    );
    final running = ref.watch(isRunningProvider(uid)).maybeWhen(
      data: (v) => v, orElse: () => false,
    );
    final paused = ref.watch(isPausedProvider(uid)).maybeWhen(
      data: (v) => v, orElse: () => false,
    );

    return Chip(
      avatar: Icon(paused ? Icons.pause : (running ? Icons.play_arrow : Icons.stop),
        color: Colors.white),
      label: Text(_fmt(elapsed), style: const TextStyle(color: Colors.white)),
      backgroundColor: paused ? Colors.orange : (running ? Colors.green : Colors.grey),
    );
  }
}
