import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../../../core/db/database_provider.dart';

class SessionView {
  final int id;
  final DateTime start;
  final DateTime? end;
  final Duration netDuration;
  SessionView({required this.id, required this.start, required this.end, required this.netDuration});
}

final sessionHistoryProvider = StreamProvider.family<List<SessionView>, int>((ref, activityId) async* {
  final db = ref.read(databaseProvider);
  await for (final sessions in db.sessionsDao.watchSessionsForActivity(activityId)) {
    final views = <SessionView>[];
    for (final s in sessions) {
      final pauses = await db.pausesDao.getPausesForSession(s.id);
      final end = s.endTs ?? DateTime.now();
      var pauseTotal = Duration.zero;
      for (final p in pauses) {
        final ps = p.startTs;
        final pe = p.endTs;
        final overlapStart = ps.isAfter(s.startTs) ? ps : s.startTs;
        final overlapEnd = pe.isBefore(end) ? pe : end;
        if (overlapEnd.isAfter(overlapStart)) {
          pauseTotal += overlapEnd.difference(overlapStart);
        }
      }
      final net = end.difference(s.startTs) - pauseTotal;
      views.add(SessionView(id: s.id, start: s.startTs, end: s.endTs, netDuration: net));
    }
    yield views;
  }
});
