import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart'; // expose dbProvider

/// Retourne la durée écoulée de la session courante.
final runningElapsedProvider =
FutureProvider.family<Duration, dynamic>((ref, activityId) {
  return ref.read(dbProvider).runningElapsed(activityId);
});

/// Vrai si l’activité est en cours.
final isRunningProvider =
FutureProvider.family<bool, dynamic>((ref, activityId) {
  return ref.read(dbProvider).isRunning(activityId);
});

/// Vrai si l’activité est en pause.
final isPausedProvider =
FutureProvider.family<bool, dynamic>((ref, activityId) {
  return ref.read(dbProvider).isPaused(activityId);
});
