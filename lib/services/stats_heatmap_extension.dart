// lib/services/stats_heatmap_extension.dart
import 'dart:math';
import 'stats_service.dart';

extension HeatmapHelpers on StatsService {
  Future<Map<DateTime, int>> lastNDays(String activityUid,
      {required int days}) async {
    final now = DateTime.now();
    final sessions = await db.listSessionsByActivity(activityUid);
    final byDate = <DateTime, int>{};

    for (final s in sessions) {
      final startAt = s.startedAt;
      final endAt = s.endedAt ?? now;

      DateTime cur = startAt;
      while (!cur.isAfter(endAt)) {
        final dayStart = DateTime(cur.year, cur.month, cur.day);
        final dayEnd = dayStart.add(const Duration(days: 1));
        final segStart = cur.isBefore(dayStart) ? dayStart : cur;
        final segEnd = endAt.isBefore(dayEnd) ? endAt : dayEnd;

        var minutes = segEnd.difference(segStart).inMinutes;

        final pauses = await db.listPausesBySession(s.id);
        for (final p in pauses) {
          final pStart = p.startedAt;
          final pEnd = p.endedAt ?? segEnd;
          final overlapStart = pStart.isAfter(segStart) ? pStart : segStart;
          final overlapEnd = pEnd.isBefore(segEnd) ? pEnd : segEnd;
          if (overlapEnd.isAfter(overlapStart)) {
            minutes -= overlapEnd.difference(overlapStart).inMinutes;
          }
        }

        byDate.update(dayStart, (v) => v + max(0, minutes),
            ifAbsent: () => max(0, minutes));
        cur = dayEnd;
      }
    }

    // remplissage des jours vides
    for (int i = 0; i < days; i++) {
      final d = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: i));
      byDate.putIfAbsent(DateTime(d.year, d.month, d.day), () => 0);
    }
    final sorted = Map.fromEntries(
        byDate.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
    return sorted;
  }
}
