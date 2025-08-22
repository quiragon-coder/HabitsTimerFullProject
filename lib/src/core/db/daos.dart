import 'package:drift/drift.dart';
import 'app_database.dart';
import 'tables.dart';

part 'daos.g.dart';

@DriftAccessor(tables: [Activities])
class ActivitiesDao extends DatabaseAccessor<AppDatabase> with _$ActivitiesDaoMixin {
  ActivitiesDao(AppDatabase db) : super(db);

  Future<int> createActivity(ActivitiesCompanion entry) => into(activities).insert(entry);
  Future<List<Activity>> getAllActivities() => select(activities).get();
  Stream<List<Activity>> watchAllActivities() => select(activities).watch();
  Future<int> deleteActivity(int id) => (delete(activities)..where((t) => t.id.equals(id))).go();
}

@DriftAccessor(tables: [Sessions, Activities])
class SessionsDao extends DatabaseAccessor<AppDatabase> with _$SessionsDaoMixin {
  SessionsDao(AppDatabase db) : super(db);

  Future<int> startSession({required int activityId, required DateTime start, String? note}) {
    return into(sessions).insert(SessionsCompanion.insert(
      activityId: activityId,
      startTs: start,
      note: Value(note),
    ));
  }

  Future<int> stopSession({required int sessionId, required DateTime end}) {
    return (update(sessions)..where((s) => s.id.equals(sessionId)))
        .write(SessionsCompanion(endTs: Value(end)));
  }

  Future<List<Session>> getSessionsForActivity(int activityId) {
    return (select(sessions)
          ..where((s) => s.activityId.equals(activityId))
          ..orderBy([
            (s) => OrderingTerm(expression: s.startTs, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Stream<List<Session>> watchSessionsForActivity(int activityId) {
    return (select(sessions)
          ..where((s) => s.activityId.equals(activityId))
          ..orderBy([
            (s) => OrderingTerm(expression: s.startTs, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Future<Session?> getActiveSession(int activityId) {
    return (select(sessions)
          ..where((s) => s.activityId.equals(activityId) & s.endTs.isNull()))
        .getSingleOrNull();
  }
}

@DriftAccessor(tables: [Pauses])
class PausesDao extends DatabaseAccessor<AppDatabase> with _$PausesDaoMixin {
  PausesDao(AppDatabase db) : super(db);

  Future<int> addPause({required int sessionId, required DateTime start, required DateTime end}) {
    return into(pauses).insert(PausesCompanion.insert(
      sessionId: sessionId,
      startTs: start,
      endTs: end,
    ));
  }

  Future<List<Pause>> getPausesForSession(int sessionId) {
    return (select(pauses)..where((p) => p.sessionId.equals(sessionId))).get();
  }
}
