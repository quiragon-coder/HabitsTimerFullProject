import 'package:habits_timer/services/database_service.dart';
import 'package:habits_timer/models/stats.dart';

/// Service de stats (aggrégations haut niveau)
class StatsService {
  final DatabaseService db;
  StatsService(this.db);

  /// Minutes effectives aujourd’hui
  int minutesToday(String activityId) {
    final now = DateTime.now();
    final day = DateTime(now.year, now.month, now.day);
    return db.effectiveMinutesOnDay(activityId, day);
  }

  /// Minutes de la semaine en cours (lundi -> aujourd’hui)
  int minutesThisWeek(String activityId) {
    final now = DateTime.now();
    // Lundi = 1 … Dimanche = 7
    final startOfWeek = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
    var total = 0;
    for (var d = startOfWeek;
    !d.isAfter(DateTime(now.year, now.month, now.day));
    d = d.add(const Duration(days: 1))) {
      total += db.effectiveMinutesOnDay(activityId, d);
    }
    return total;
  }

  /// Minutes du mois courant (1er -> aujourd’hui)
  int minutesThisMonth(String activityId) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    var total = 0;
    for (var d = startOfMonth;
    !d.isAfter(DateTime(now.year, now.month, now.day));
    d = d.add(const Duration(days: 1))) {
      total += db.effectiveMinutesOnDay(activityId, d);
    }
    return total;
  }

  /// Minutes de l’année courante (1er jan -> aujourd’hui)
  int minutesThisYear(String activityId) {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    var total = 0;
    for (var d = startOfYear;
    !d.isAfter(DateTime(now.year, now.month, now.day));
    d = d.add(const Duration(days: 1))) {
      total += db.effectiveMinutesOnDay(activityId, d);
    }
    return total;
  }

  /// Derniers [days] jours (inclus aujourd’hui), pour les graphes/jauges
  Future<List<DailyStat>> lastNDays(String activityId, int days) async {
    final now = DateTime.now();
    final end = DateTime(now.year, now.month, now.day);
    final start = end.subtract(Duration(days: days - 1));

    final list = <DailyStat>[];
    for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
      list.add(DailyStat(date: d, minutes: db.effectiveMinutesOnDay(activityId, d)));
    }
    return list;
  }

  /// Buckets horaires (0..23) pour aujourd’hui (utile aux bar charts)
  List<int> hourlyToday(String activityId) => db.hourlyToday(activityId);
}
