import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/database_service_contract.dart';

class LastNDaysArgs {
  LastNDaysArgs({required this.activityId, required this.days});
  final int activityId;
  final int days;
  String get uid => activityId.toString();
}

final lastNDaysMapProvider = FutureProvider.family<Map<DateTime, int>, LastNDaysArgs>((ref, args) {
  return ref.read(dbProvider).lastNDaysMap(args.uid, days: args.days);
});
