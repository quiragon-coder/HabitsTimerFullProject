import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

/// Stream<Duration> qui “tique” chaque seconde avec la durée courante.
final runningElapsedProvider =
StreamProvider.family<Duration, String>((ref, activityId) {
  final db = ref.watch(dbProvider);
  // un tick immédiat puis toutes les secondes
  return Stream<Duration>.periodic(const Duration(seconds: 1), (_) {
    return db.runningElapsed(activityId);
  }).startWith(db.runningElapsed(activityId));
});

/// Stream<bool> qui “tique” chaque seconde avec l’état running
final isRunningProvider = StreamProvider.family<bool, String>((ref, activityId) {
  final db = ref.watch(dbProvider);
  return Stream<bool>.periodic(const Duration(seconds: 1), (_) {
    return db.isRunning(activityId);
  }).startWith(db.isRunning(activityId));
});

/// Stream<bool> pour l’état paused
final isPausedProvider = StreamProvider.family<bool, String>((ref, activityId) {
  final db = ref.watch(dbProvider);
  return Stream<bool>.periodic(const Duration(seconds: 1), (_) {
    return db.isPaused(activityId);
  }).startWith(db.isPaused(activityId));
});

/// Petit utilitaire pour démarrer un stream avec une valeur immédiate.
extension _StartWith<T> on Stream<T> {
  Stream<T> startWith(T value) async* {
    yield value;
    yield* this;
  }
}
