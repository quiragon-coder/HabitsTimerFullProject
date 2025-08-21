import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../providers_timer.dart';

class ActivityControls extends ConsumerWidget {
  const ActivityControls({super.key, required this.activityId});
  final int activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Les providers prennent un uid (String)
    final activityUid = activityId.toString();
    final running =
        ref.watch(isRunningStreamProvider(activityUid)).value ?? false;
    final paused =
        ref.watch(isPausedStreamProvider(activityUid)).value ?? false;

    return Row(
      children: [
        FilledButton.icon(
          onPressed: () async {
            final db = ref.read(dbProvider);
            if (!running) {
              // DatabaseService attend un String pour activityId
              await db.start(activityId: activityUid);
            } else {
              await db.togglePause(activityId: activityUid);
            }
          },
          icon: const Icon(Icons.pause),
          label: Text(paused ? 'Reprendre' : (running ? 'Pause' : 'Démarrer')),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: running
              ? () async => ref.read(dbProvider).stop(activityId: activityUid)
              : null,
          icon: const Icon(Icons.stop),
          label: const Text('Arrêter'),
        ),
      ],
    );
  }
}
