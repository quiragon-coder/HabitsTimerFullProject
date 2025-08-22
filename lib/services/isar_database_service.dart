import 'dart:async';

import 'package:habits_timer/models/activity_entity.dart';
import 'package:habits_timer/models/pause_entity.dart';
import 'package:habits_timer/models/session_entity.dart';
import 'package:habits_timer/services/database_service_contract.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart' as pp;

class IsarDatabaseService implements DatabaseService {
  IsarDatabaseService._(this._isar);

  final Isar _isar;

  static Future<IsarDatabaseService> create() async {
    final dir = await pp.getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [ActivityEntitySchema, SessionEntitySchema, PauseEntitySchema],
      directory: dir.path,
      name: 'habits_timer',
    );
    return IsarDatabaseService._(isar);
  }

  // --- Mapping helpers ---

  Activity _toActivity(ActivityEntity e) => Activity(
    id: e.id,
    name: e.name,
    emoji: e.emoji,
    colorValue: e.colorValue,
    dailyGoalMinutes: e.dailyGoalMinutes,
    weeklyGoalMinutes: e.weeklyGoalMinutes,
    monthlyGoalMinutes: e.monthlyGoalMinutes,
    yearlyGoalMinutes: e.yearlyGoalMinutes,
  );

  DbSession _toDbSession(SessionEntity s) => DbSession(
    id: s.id,
    activityId: s.activityId,
    startedAt: s.startedAt,
    endedAt: s.endedAt,
  );

  DbPause _toDbPause(PauseEntity p) => DbPause(
    id: p.id,
    sessionId: p.sessionId,
    startAt: p.startAt,
    endAt: p.endAt,
  );

  // --- DatabaseService impl ---

  @override
  Stream<List<Activity>> watchActivities() {
    return _isar.activityEntitys
        .where()
        .watch(fireImmediately: true)
        .map((list) => list.map(_toActivity).toList());
  }

  @override
  Future<Activity> createActivity({
    required String name,
    required String emoji,
    required int colorValue,
    int dailyGoalMinutes = 0,
    int weeklyGoalMinutes = 0,
    int monthlyGoalMinutes = 0,
    int yearlyGoalMinutes = 0,
  }) async {
    final e = ActivityEntity()
      ..name = name
      ..emoji = emoji
      ..colorValue = colorValue
      ..dailyGoalMinutes = dailyGoalMinutes
      ..weeklyGoalMinutes = weeklyGoalMinutes
      ..monthlyGoalMinutes = monthlyGoalMinutes
      ..yearlyGoalMinutes = yearlyGoalMinutes;

    await _isar.writeTxn(() async {
      await _isar.activityEntitys.put(e);
    });
    return _toActivity(e);
  }

  @override
  Future<void> start(int activityId) async {
    await _isar.writeTxn(() async {
      final existing = await _isar.sessionEntitys
          .filter()
          .activityIdEqualTo(activityId)
          .and()
          .endedAtIsNull()
          .findFirst();

      if (existing != null) {
        final pause = await _openPauseForSession(existing.id);
        if (pause != null) {
          pause.endAt = DateTime.now().toUtc();
          await _isar.pauseEntitys.put(pause);
        }
        return;
      }

      final s = SessionEntity()
        ..activityId = activityId
        ..startedAt = DateTime.now().toUtc()
        ..endedAt = null;

      await _isar.sessionEntitys.put(s);
    });
  }

  @override
  Future<void> togglePause(int activityId) async {
    await _isar.writeTxn(() async {
      final session = await _activeSessionForActivity(activityId);
      if (session == null) return;

      final open = await _openPauseForSession(session.id);
      if (open != null) {
        open.endAt = DateTime.now().toUtc();
        await _isar.pauseEntitys.put(open);
      } else {
        final p = PauseEntity()
          ..sessionId = session.id
          ..startAt = DateTime.now().toUtc()
          ..endAt = null;
        await _isar.pauseEntitys.put(p);
      }
    });
  }

  @override
  Future<void> stop(int activityId) async {
    await _isar.writeTxn(() async {
      final session = await _activeSessionForActivity(activityId);
      if (session == null) return;

      final open = await _openPauseForSession(session.id);
      if (open != null) {
        open.endAt = DateTime.now().toUtc();
        await _isar.pauseEntitys.put(open);
      }

      session.endedAt = DateTime.now().toUtc();
      await _isar.sessionEntitys.put(session);
    });
  }

  @override
  Stream<Duration> runningElapsedNow(String activityUid) {
    final activityId = int.tryParse(activityUid);
    if (activityId == null) return Stream.value(Duration.zero);

    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      final s = await _activeSessionForActivity(activityId);
      if (s == null) return Duration.zero;

      final now = DateTime.now().toUtc();
      final end = s.endedAt ?? now;
      final paused = await _totalPausedBetween(s.id, s.startedAt, end);
      final elapsed = end.difference(s.startedAt) - paused;
      return elapsed.isNegative ? Duration.zero : elapsed;
    }).distinct((a, b) => a.inSeconds == b.inSeconds);
  }

  @override
  Stream<bool> isRunningNow(String activityUid) {
    final activityId = int.tryParse(activityUid);
    if (activityId == null) return Stream.value(false);

    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      final s = await _activeSessionForActivity(activityId);
      return s != null;
    }).distinct();
  }

  @override
  Stream<bool> isPausedNow(String activityUid) {
    final activityId = int.tryParse(activityUid);
    if (activityId == null) return Stream.value(false);

    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      final s = await _activeSessionForActivity(activityId);
      if (s == null) return false;
      final p = await _openPauseForSession(s.id);
      return p != null;
    }).distinct();
  }

  @override
  Future<List<DbSession>> listSessionsByActivity(int activityId) async {
    final raw = await _isar.sessionEntitys
        .filter()
        .activityIdEqualTo(activityId)
        .findAll();

    raw.sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return raw.map(_toDbSession).toList();
  }

  @override
  Future<List<DbPause>> listPausesBySession(int sessionId) async {
    final raw = await _isar.pauseEntitys
        .filter()
        .sessionIdEqualTo(sessionId)
        .findAll();
    raw.sort((a, b) => a.startAt.compareTo(b.startAt));
    return raw.map(_toDbPause).toList();
  }

  @override
  Future<int> effectiveMinutesOnDay(int activityId, DateTime date) async {
    final dayStartLocal = DateTime(date.year, date.month, date.day);
    final dayEndLocal = dayStartLocal.add(const Duration(days: 1));

    final start = dayStartLocal.toUtc();
    final end = dayEndLocal.toUtc();

    final sessions = await _isar.sessionEntitys
        .filter()
        .activityIdEqualTo(activityId)
        .and()
        .startedAtLessThan(end)
        .and()
        .group((q) => q.endedAtIsNull().or().endedAtGreaterThan(start))
        .findAll();

    var total = Duration.zero;
    for (final s in sessions) {
      final sEnd = s.endedAt ?? DateTime.now().toUtc();
      final overlap = _overlapBetween(s.startedAt, sEnd, start, end);
      if (overlap > Duration.zero) {
        final paused = await _totalPausedBetween(s.id, start, end);
        final eff = overlap - paused;
        if (!eff.isNegative) total += eff;
      }
    }
    return total.inMinutes;
  }

  @override
  Future<Map<DateTime, int>> lastNDaysMap(String activityUid,
      {required int days}) async {
    final activityId = int.parse(activityUid);
    final map = <DateTime, int>{};

    for (int i = 0; i < days; i++) {
      final date = DateTime.now().subtract(Duration(days: i));
      final key = DateTime(date.year, date.month, date.day);
      final minutes = await effectiveMinutesOnDay(activityId, date);
      map[key] = minutes;
    }
    return map;
  }

  // --- Helpers internes ---

  Future<SessionEntity?> _activeSessionForActivity(int activityId) {
    return _isar.sessionEntitys
        .filter()
        .activityIdEqualTo(activityId)
        .and()
        .endedAtIsNull()
        .findFirst();
  }

  Future<PauseEntity?> _openPauseForSession(int sessionId) {
    return _isar.pauseEntitys
        .filter()
        .sessionIdEqualTo(sessionId)
        .and()
        .endAtIsNull()
        .findFirst();
  }

  Future<Duration> _totalPausedBetween(
      int sessionId, DateTime from, DateTime to) async {
    final pauses = await _isar.pauseEntitys
        .filter()
        .sessionIdEqualTo(sessionId)
        .and()
        .startAtLessThan(to)
        .and()
        .group((q) => q.endAtIsNull().or().endAtGreaterThan(from))
        .findAll();

    var total = Duration.zero;
    for (final p in pauses) {
      final pEnd = p.endAt ?? DateTime.now().toUtc();
      total += _overlapBetween(p.startAt, pEnd, from, to);
    }
    return total;
  }

  Duration _overlapBetween(
      DateTime aStart, DateTime aEnd, DateTime bStart, DateTime bEnd) {
    final start = aStart.isAfter(bStart) ? aStart : bStart;
    final end = aEnd.isBefore(bEnd) ? aEnd : bEnd;
    if (end.isBefore(start)) return Duration.zero;
    return end.difference(start);
  }
}
