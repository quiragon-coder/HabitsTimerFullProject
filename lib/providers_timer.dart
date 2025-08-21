import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';

final elapsedStreamProvider =
StreamProvider.family<Duration, String>((ref, activityUid) {
  final db = ref.read(dbProvider);
  return Stream.periodic(
    const Duration(seconds: 1),
        (_) => db.runningElapsedNow(activityId: activityUid),
  );
});

final isRunningStreamProvider =
StreamProvider.family<bool, String>((ref, activityUid) {
  final db = ref.read(dbProvider);
  return Stream.periodic(
    const Duration(seconds: 1),
        (_) => db.isRunningNow(activityId: activityUid),
  );
});

final isPausedStreamProvider =
StreamProvider.family<bool, String>((ref, activityUid) {
  final db = ref.read(dbProvider);
  return Stream.periodic(
    const Duration(seconds: 1),
        (_) => db.isPausedNow(activityId: activityUid),
  );
});
