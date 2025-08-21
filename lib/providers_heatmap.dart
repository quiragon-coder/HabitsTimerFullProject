import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_timer/providers.dart'; // dbProvider, maybe activity provider, etc.
import 'package:habits_timer/services/stats_service.dart';
import 'package:habits_timer/services/stats_heatmap_extension.dart';

/// Map<DateTime, int> des minutes par jour pour la période affichée par le heatmap.
final heatmapProvider = FutureProvider.family<Map<DateTime, int>, String>((ref, activityId) {
  final db = ref.read(dbProvider);
  final stats = StatsService(db);

  final now = DateTime.now();
  // Exemple: sur 90 jours glissants
  final from = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 89));
  final to = DateTime(now.year, now.month, now.day);

  return stats.dailyMinutesRange(activityId: activityId, from: from, to: to);
});
