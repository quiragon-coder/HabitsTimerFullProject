import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/database_service_contract.dart';

final dbProvider = Provider<DatabaseService>((ref) {
  throw UnimplementedError('Provide a DatabaseService via ProviderScope(overrides: [...])');
});

final elapsedStreamProvider = StreamProvider.family<Duration, String>((ref, activityUid) {
  return ref.read(dbProvider).runningElapsedNow(activityUid);
});
final isRunningProvider = StreamProvider.family<bool, String>((ref, activityUid) {
  return ref.read(dbProvider).isRunningNow(activityUid);
});
final isPausedProvider = StreamProvider.family<bool, String>((ref, activityUid) {
  return ref.read(dbProvider).isPausedNow(activityUid);
});
