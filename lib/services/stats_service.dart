// lib/services/stats_service.dart
import '../providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'stats_heatmap_extension.dart';
import 'database_service.dart';

final statsProvider = Provider<StatsService>((ref) {
  final db = ref.read(dbProvider);
  return StatsService(db);
});

class StatsService {
  final DatabaseService db;
  StatsService(this.db);

  Future<int> effectiveMinutesOnDay(String activityUid, DateTime date) async {
    final sessions = await db.listSessionsByActivity(activityUid);
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    var total = 0;

    for (final s in sessions) {
      final sStart = s.startedAt;
      final sEnd = s.endedAt ?? DateTime.now();
      final segStart = sStart.isAfter(start) ? sStart : start;
      final segEnd = sEnd.isBefore(end) ? sEnd : end;
      if (!segEnd.isAfter(segStart)) continue;

      var minutes = segEnd.difference(segStart).inMinutes;
      final pauses = await db.listPausesBySession(s.id);
      for (final p in pauses) {
        final pStart = p.startedAt;
        final pEnd = (p.endedAt ?? segEnd);
        final overlapStart = pStart.isAfter(segStart) ? pStart : segStart;
        final overlapEnd = pEnd.isBefore(segEnd) ? pEnd : segEnd;
        if (overlapEnd.isAfter(overlapStart)) {
          minutes -= overlapEnd.difference(overlapStart).inMinutes;
        }
      }
      total += minutes;
    }
    return total < 0 ? 0 : total;
  }

  Future<Map<DateTime, int>> lastNDaysMap(String activityUid,
      {required int days}) {
    return lastNDays(activityUid, days: days);
  }
}
