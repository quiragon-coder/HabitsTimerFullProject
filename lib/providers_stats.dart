import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habits_timer/providers.dart';              // dbProvider
import 'package:habits_timer/models/stats.dart';           // DailyStat, HourlyBucket (si besoin)
import 'package:habits_timer/services/stats_service.dart'; // StatsService

/// Petit wrapper pour passer (activityId, days) à un provider .family
class LastNDaysArgs {
  final String activityId;
  final int days;
  const LastNDaysArgs({required this.activityId, required this.days});
}

/// Fournit une instance de StatsService basée sur le DatabaseService
final statsServiceProvider = Provider<StatsService>((ref) {
  final db = ref.read(dbProvider);
  return StatsService(db);
});

/// Minutes aujourd’hui
final minutesTodayProvider = FutureProvider.family<int, String>((ref, activityId) async {
  final stats = ref.read(statsServiceProvider);
  return stats.minutesToday(activityId);
});

/// Minutes cette semaine
final minutesThisWeekProvider = FutureProvider.family<int, String>((ref, activityId) async {
  final stats = ref.read(statsServiceProvider);
  return stats.minutesThisWeek(activityId);
});

/// Minutes ce mois
final minutesThisMonthProvider = FutureProvider.family<int, String>((ref, activityId) async {
  final stats = ref.read(statsServiceProvider);
  return stats.minutesThisMonth(activityId);
});

/// Minutes cette année
final minutesThisYearProvider = FutureProvider.family<int, String>((ref, activityId) async {
  final stats = ref.read(statsServiceProvider);
  return stats.minutesThisYear(activityId);
});

/// Derniers N jours (pour heatmap/mini-heatmap)
final lastNDaysProvider =
FutureProvider.family<List<DailyStat>, LastNDaysArgs>((ref, args) async {
  final stats = ref.read(statsServiceProvider);
  return stats.lastNDays(args.activityId, args.days);
});

/// Buckets horaires d’aujourd’hui (24 valeurs)
final hourlyTodayProvider = FutureProvider.family<List<int>, String>((ref, activityId) async {
  final stats = ref.read(statsServiceProvider);
  return stats.hourlyToday(activityId);
});
