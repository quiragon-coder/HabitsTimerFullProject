import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

/// Emits the elapsed time for the running session of [activityId],
/// refreshed every second.
final runningElapsedProvider =
StreamProvider.family<Duration, int>((ref, activityId) {
  final db = ref.read(dbProvider);

  final controller = StreamController<Duration>();
  Timer? timer;

  Future<void> emit() async {
    try {
      // Database API expected to be: Future<Duration> runningElapsed(int activityId)
      final d = await db.runningElapsed(activityId);
      controller.add(d);
    } catch (_) {
      // keep alive even if DB throws temporarily
    }
  }

  controller.onListen = () {
    emit(); // immediate value
    timer = Timer.periodic(const Duration(seconds: 1), (_) => emit());
  };

  controller.onCancel = () {
    timer?.cancel();
  };

  ref.onDispose(() {
    timer?.cancel();
    controller.close();
  });

  return controller.stream.distinct();
});

/// True while the activity is started, refreshed every second.
final isRunningProvider = StreamProvider.family<bool, int>((ref, activityId) {
  final db = ref.read(dbProvider);
  return Stream<bool>.periodic(const Duration(seconds: 1))
      .asyncMap((_) => db.isRunning(activityId))
      .distinct();
});

/// True while the activity is paused, refreshed every second.
final isPausedProvider = StreamProvider.family<bool, int>((ref, activityId) {
  final db = ref.read(dbProvider);
  return Stream<bool>.periodic(const Duration(seconds: 1))
      .asyncMap((_) => db.isPaused(activityId))
      .distinct();
});
