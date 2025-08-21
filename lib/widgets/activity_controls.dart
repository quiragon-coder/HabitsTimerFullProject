import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../providers_timer.dart';

class ActivityControls extends ConsumerWidget {
  const ActivityControls({super.key, required this.activityId});

  final int activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final running = ref.watch(isRunningProvider(activityId)).value ?? false;
    final paused  = ref.watch(isPausedProvider(activityId)).value ?? false;
    final db = ref.read(dbProvider);

    const btnPadding = EdgeInsets.symmetric(horizontal: 4, vertical: 2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!running)
          IconButton.filled(
            onPressed: () async => db.start(activityId),
            icon: const Icon(Icons.play_arrow),
            tooltip: 'Start',
            padding: btnPadding,
          ),
        if (running) ...[
          IconButton.filled(
            onPressed: () async => db.togglePause(activityId),
            icon: Icon(paused ? Icons.play_arrow : Icons.pause),
            tooltip: paused ? 'Resume' : 'Pause',
            padding: btnPadding,
          ),
          IconButton.filled(
            onPressed: () async => db.stop(activityId),
            icon: const Icon(Icons.stop),
            tooltip: 'Stop',
            padding: btnPadding,
          ),
        ],
      ],
    );
  }
}
