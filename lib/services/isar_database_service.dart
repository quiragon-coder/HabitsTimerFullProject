import 'dart:async';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'database_service_contract.dart';
import '../models/activity_entity.dart';
import '../models/session_entity.dart';
import '../models/pause_entity.dart';

class IsarDatabaseService implements DatabaseService {
  final Isar _isar;
  IsarDatabaseService._(this._isar);

  static Future<IsarDatabaseService> create() async {
    final dir = await pp.getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      schemas: [ActivityEntitySchema, SessionEntitySchema, PauseEntitySchema],
      directory: dir.path,
      name: 'habits_timer',
    );
    return IsarDatabaseService._(isar);
  }

  // ---------- Helpers mapping ----------
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

  // ---------- Activities ----------
  @override
  Stream<List<Activity>> watchActivities() {
    final q = _isar.activityEntitys.where().build();
    return q.watch(fireImmediately: true).map((list) => list.map(_toActivity).toList());
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
    final entity = ActivityEntity()
      ..name = name
      ..emoji = emoji
      ..colorValue = colorValue
      ..dailyGoalMinutes = dailyGoalMinutes
      ..weeklyGoalMinutes = weeklyGoalMinutes
      ..monthlyGoalMinutes = monthlyGoalMinutes
      ..yearlyGoalMinutes = yearlyGoalMinutes;

    await _isar.writeTxn(() async {
      await _isar.activityEntitys.put(entity);
    });
    return _toActivity(entity);
  }

  // ---------- Timer controls ----------
  Future<SessionEntity?> _openSessionFor(int activityId) async {
    return await _isar.sessionEntitys
        .where()
        .filter()
        .activityIdEqualTo(activityId)
        .and()
        .endedAtIsNull()
        .findFirst();
  }

  Future<PauseEntity?> _openPauseFor(int sessionId) async {
    return await _isar.pauseEntitys
        .where()
        .filter()
        .sessionIdEqualTo(sessionId)
        .and()
        .endAtIsNull()
        .findFirst();
  }

  @override
  Future<void> start(int activityId) async {
    await _isar.writeTxn(() async {
      final open = await _openSessionFor(activityId);
      if (open != null) return; // déjà en cours
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
      final s = await _openSessionFor(activityId);
      if (s == null) return; // rien à pauser
      final p = await _openPauseFor(s.id);
      if (p == null) {
        // démarrer une pause
        final np = PauseEntity()
          ..sessionId = s.id
          ..startAt = DateTime.now().toUtc()
          ..endAt = null;
        await _isar.pauseEntitys.put(np);
      } else {
        // arrêter la pause
        p.endAt = DateTime.now().toUtc();
        await _isar.pauseEntitys.put(p);
      }
    });
  }

  @override
  Future<void> stop(int activityId) async {
    await _isar.writeTxn(() async {
      final s = await _openSessionFor(activityId);
      if (s == null) return;
      // fermer une pause ouverte si besoin
      final p = await _openPauseFor(s.id);
      if (p != null) {
        p.endAt = DateTime.now().toUtc();
        await _isar.pauseEntitys.put(p);
      }
      s.endedAt = DateTime.now().toUtc();
      await _isar.sessionEntitys.put(s);
    });
  }

  // ---------- State streams ----------
  @override
  Stream<Duration> runningElapsedNow(String activityUid) async* {
    final activityId = int.tryParse(activityUid);
    if (activityId == null) yield Duration.zero;
    // tick toutes les secondes
    yield* Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      final s = await _openSessionFor(activityId!);
      if (s == null) return Duration.zero;
      final now = DateTime.now().toUtc();
      final pauses = await _isar.pauseEntitys
          .where()
          .filter()
          .sessionIdEqualTo(s.id)
          .findAll();
      final totalPause = _totalOverlap(pauses.map((p) => (p.startAt, p.endAt ?? now)).toList(), s.startedAt, now);
      final elapsed = now.difference(s.startedAt) - totalPause;
      return elapsed.isNegative ? Duration.zero : elapsed;
    });
  }

  @override
  Stream<bool> isRunningNow(String activityUid) {
    final activityId = int.tryParse(activityUid);
    if (activityId == null) return Stream.value(false);
    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      final s = await _openSessionFor(activityId);
      return s != null;
    }).distinct();
  }

  @override
  Stream<bool> isPausedNow(String activityUid) {
    final activityId = int.tryParse(activityUid);
    if (activityId == null) return Stream.value(false);
    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      final s = await _openSessionFor(activityId);
      if (s == null) return false;
      final p = await _openPauseFor(s.id);
      return p != null;
    }).distinct();
  }

  // ---------- History ----------
  @override
  Future<List<DbSession>> listSessionsByActivity(int activityId) async {
    final list = await _isar.sessionEntitys
        .where()
        .filter()
        .activityIdEqualTo(activityId)
        .sortByStartedAtDesc()
        .findAll();
    return list.map(_toDbSession).toList();
  }

  @override
  Future<List<DbPause>> listPausesBySession(int sessionId) async {
    final list = await _isar.pauseEntitys
        .where()
        .filter()
        .sessionIdEqualTo(sessionId)
        .sortByStartAtDesc()
        .findAll();
    return list.map(_toDbPause).toList();
  }

  // ---------- Stats ----------
  @override
  Future<int> effectiveMinutesOnDay(int activityId, DateTime date) async {
    final dayStart = DateTime.utc(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final sessions = await _isar.sessionEntitys
        .where()
        .filter()
        .activityIdEqualTo(activityId)
        .findAll();

    int seconds = 0;
    for (final s in sessions) {
      final sStart = s.startedAt;
      final sEnd = s.endedAt ?? DateTime.now().toUtc();
      final overlap = _overlapBetween(sStart, sEnd, dayStart, dayEnd);
      if (overlap <= Duration.zero) continue;

      final pauses = await _isar.pauseEntitys
          .where()
          .filter()
          .sessionIdEqualTo(s.id)
          .findAll();
      final pauseDur = _totalOverlap(
          pauses.map((p) => (p.startAt, p.endAt ?? DateTime.now().toUtc())).toList(),
          dayStart,
          dayEnd);
      final eff = overlap - pauseDur;
      if (!eff.isNegative) seconds += eff.inSeconds;
    }
    // arrondi à la minute inférieure
    return seconds ~/ 60;
  }

  @override
  Future<Map<DateTime, int>> lastNDaysMap(String activityUid, {required int days}) async {
    final activityId = int.parse(activityUid);
    final now = DateTime.now().toUtc();
    final Map<DateTime, int> out = {};
    for (int i = days - 1; i >= 0; i--) {
      final d = now.subtract(Duration(days: i));
      final key = DateTime.utc(d.year, d.month, d.day);
      out[key] = await effectiveMinutesOnDay(activityId, d);
    }
    return out;
  }

  // ---------- Time math helpers ----------
  Duration _overlapBetween(DateTime aStart, DateTime aEnd, DateTime bStart, DateTime bEnd) {
    final start = aStart.isAfter(bStart) ? aStart : bStart;
    final end = aEnd.isBefore(bEnd) ? aEnd : bEnd;
    return end.isAfter(start) ? end.difference(start) : Duration.zero;
  }

  Duration _totalOverlap(List<(DateTime, DateTime)> ranges, DateTime winStart, DateTime winEnd) {
    Duration total = Duration.zero;
    for (final (rs, re) in ranges) {
      total += _overlapBetween(rs, re, winStart, winEnd);
    }
    return total;
  }
}
