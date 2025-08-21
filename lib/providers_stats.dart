import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'services/stats_service.dart';

final statsProvider = Provider<StatsService>((ref) {
  final db = ref.read(dbProvider);
  return StatsService(db);
});

final minutesTodayProvider = FutureProvider.family<int, String>((ref, activityId) {
  return ref.read(statsProvider).minutesToday(activityId);
});

final minutesThisWeekProvider = FutureProvider.family<int, String>((ref, activityId) {
  return ref.read(statsProvider).minutesThisWeek(activityId);
});

final minutesThisMonthProvider = FutureProvider.family<int, String>((ref, activityId) {
  return ref.read(statsProvider).minutesThisMonth(activityId);
});

final minutesThisYearProvider = FutureProvider.family<int, String>((ref, activityId) {
  return ref.read(statsProvider).minutesThisYear(activityId);
});

class LastNDaysArgs {
  final String activityId;
  final int days;
  const LastNDaysArgs({required this.activityId, required this.days});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LastNDaysArgs &&
              runtimeType == other.runtimeType &&
              activityId == other.activityId &&
              days == other.days;

  @override
  int get hashCode => Object.hash(activityId, days);
}

final lastNDaysProvider =
FutureProvider.family<Map<DateTime, int>, LastNDaysArgs>((ref, args) {
  return ref.read(statsProvider).lastNDays(args.activityId, days: args.days);
});
