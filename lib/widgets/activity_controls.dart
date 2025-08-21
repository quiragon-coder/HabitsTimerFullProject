import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers_timer.dart';

class ActivityControls extends ConsumerWidget {
  const ActivityControls({super.key, required this.activityId});
  final int activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);
    final uid = activityId.toString();
    final running = ref.watch(isRunningProvider(uid)).maybeWhen(data: (v)=>v, orElse: ()=>false);
    final paused = ref.watch(isPausedProvider(uid)).maybeWhen(data: (v)=>v, orElse: ()=>false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: running ? null : () => db.start(activityId),
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start'),
        ),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: running ? () => db.togglePause(activityId) : null,
          icon: Icon(paused ? Icons.play_circle : Icons.pause),
          label: Text(paused ? 'Resume' : 'Pause'),
        ),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: running ? () => db.stop(activityId) : null,
          icon: const Icon(Icons.stop),
          label: const Text('Stop'),
        ),
      ],
    );
  }
}
