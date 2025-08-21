import 'package:habits_timer/services/stats_service.dart';
import 'package:habits_timer/services/database_service.dart';

/// Extension "Heatmap" sur StatsService.
/// Fournit les minutes par jour sur un intervalle [from..to] inclus.
extension StatsHeatmapExt on StatsService {
  /// Retourne une map Date -> minutes effectives sur cette journée
  /// (sessions - pauses + session en cours si aujourd’hui).
  Future<Map<DateTime, int>> dailyMinutesRange({
    required String activityId,
    required DateTime from,
    required DateTime to,
  }) async {
    // Normalise aux minuits, et boucle jour par jour.
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day);

    final map = <DateTime, int>{};
    for (DateTime d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
      // On délègue au calcul fiable du DatabaseService qui gère
      // sessions, pauses et éventuelle exécution en cours.
      final minutes = db.effectiveMinutesOnDay(activityId, d);
      map[d] = minutes;
    }
    return map;
  }
}
