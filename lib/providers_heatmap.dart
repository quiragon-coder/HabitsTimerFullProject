import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/database_service_contract.dart';
import 'providers_timer.dart';

class LastNDaysArgs {
  LastNDaysArgs({required this.activityId, required this.days});
  final int activityId;
  final int days;
  String get uid => activityId.toString();
}

/// Map<DateTime, int> (minutes par jour) pour une activité
final lastNDaysMapProvider =
FutureProvider.family<Map<DateTime, int>, LastNDaysArgs>((ref, args) {
  final db = ref.read(dbProvider);
  return db.lastNDaysMap(args.uid, days: args.days);
});
