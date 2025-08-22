import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import '../services/database_service_contract.dart';

/// Implémentation "mémoire" pour le Web (Chrome).
/// - Persistance: AUCUNE (reset à chaque refresh).
/// - Suffisant pour tester l'UI : start/pause/stop, historique, heatmap/stats.
///
/// ⚠️ N'UTILISE PAS ISAR. À réserver au web/émulateur.
class WebDatabaseService implements DatabaseService {
  WebDatabaseService._();

  static Future<WebDatabaseService> create() async => WebDatabaseService._();

  // --- In-memory stores ---
  final List<Activity> _activities = [];
  final List<DbSession> _sessions = [];
  final List<DbPause> _pauses = [];

  int _nextActivityId = 1;
  int _nextSessionId = 1;
  int _nextPauseId = 1;

  // --- Streams (elapsed / running / paused) par activité ---
  final Map<String, StreamController<Duration>> _elapsedCtrls = {};
  final Map<String, StreamController<bool>> _runningCtrls = {};
  final Map<String, StreamController<bool>> _pausedCtrls = {};
  final Map<String, Timer> _tickers = {};

  // activités
  final _activitiesCtrl = StreamController<List<Activity>>.broadcast();

  // Helpers UTC
  DateTime _now() => DateTime.now().toUtc();

  // ---------- DatabaseService impl ----------

  @override
  Stream<List<Activity>> watchActivities() {
    // Émet immédiatement l'état courant
    scheduleMicrotask(() => _activitiesCtrl.add(List.unmodifiable(_activities)));
    return _activitiesCtrl.stream;
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
    final a = Activity(
      id: _nextActivityId++,
      name: name,
      emoji: emoji,
      colorValue: colorValue,
      dailyGoalMinutes: dailyGoalMinutes,
      weeklyGoalMinutes: weeklyGoalMinutes,
      monthlyGoalMinutes: monthlyGoalMinutes,
      yearlyGoalMinutes: yearlyGoalMinutes,
    );
    _activities.add(a);
    _activitiesCtrl.add(List.unmodifiable(_activities));
    return a;
  }

  @override
  Future<void> start(int activityId) async {
    // Si déjà une session ouverte -> juste "reprendre" (fermer pause si besoin)
    final open = _sessions.firstWhereOrNull(
          (s) => s.activityId == activityId && s.endedAt == null,
    );

    if (open != null) {
      // Fermer pause ouverte s'il y en a une
      final p = _pauses.firstWhereOrNull(
            (p) => p.sessionId == open.id && p.endAt == null,
      );
      if (p != null) {
        final idx = _pauses.indexOf(p);
        _pauses[idx] = DbPause(
          id: p.id,
          sessionId: p.sessionId,
          startAt: p.startAt,
          endAt: _now(),
        );
      }
      _notifyRunning(activityId.toString(), running: true);
      _notifyPaused(activityId.toString(), paused: false);
      _ensureTicker(activityId.toString());
      return;
    }

    // Sinon nouvelle session
    final s = DbSession(
      id: _nextSessionId++,
      activityId: activityId,
      startedAt: _now(),
      endedAt: null,
    );
    _sessions.add(s);

    final uid = activityId.toString();
    _notifyRunning(uid, running: true);
    _notifyPaused(uid, paused: false);
    _ensureTicker(uid);
  }

  @override
  Future<void> togglePause(int activityId) async {
    final s = _sessions.firstWhereOrNull(
          (x) => x.activityId == activityId && x.endedAt == null,
    );
    if (s == null) return;

    final open = _pauses.firstWhereOrNull(
          (p) => p.sessionId == s.id && p.endAt == null,
    );

    final uid = activityId.toString();

    if (open != null) {
      // Fermer pause
      final idx = _pauses.indexOf(open);
      _pauses[idx] = DbPause(
        id: open.id,
        sessionId: open.sessionId,
        startAt: open.startAt,
        endAt: _now(),
      );
      _notifyPaused(uid, paused: false);
      _ensureTicker(uid);
    } else {
      // Ouvrir pause
      final p = DbPause(
        id: _nextPauseId++,
        sessionId: s.id,
        startAt: _now(),
        endAt: null,
      );
      _pauses.add(p);
      _notifyPaused(uid, paused: true);
      // pas d'arrêt du ticker : on continue d’émettre elapsed (qui n’augmente plus)
      _ensureTicker(uid);
    }
  }

  @override
  Future<void> stop(int activityId) async {
    final s = _sessions.firstWhereOrNull(
          (x) => x.activityId == activityId && x.endedAt == null,
    );
    if (s == null) return;

    // Fermer éventuelle pause
    final open = _pauses.firstWhereOrNull(
          (p) => p.sessionId == s.id && p.endAt == null,
    );
    if (open != null) {
      final idx = _pauses.indexOf(open);
      _pauses[idx] = DbPause(
        id: open.id,
        sessionId: open.sessionId,
        startAt: open.startAt,
        endAt: _now(),
      );
    }

    // Fermer la session
    final i = _sessions.indexOf(s);
    _sessions[i] = DbSession(
      id: s.id,
      activityId: s.activityId,
      startedAt: s.startedAt,
      endedAt: _now(),
    );

    final uid = activityId.toString();
    _notifyRunning(uid, running: false);
    _notifyPaused(uid, paused: false);
    _stopTicker(uid);
    _emitElapsed(uid); // force un dernier tick propre
  }

  @override
  Stream<Duration> runningElapsedNow(String activityUid) {
    final ctrl = _elapsedCtrls.putIfAbsent(
      activityUid,
          () => StreamController<Duration>.broadcast(),
    );
    // émettre immédiatement la valeur actuelle
    scheduleMicrotask(() => _emitElapsed(activityUid));
    return ctrl.stream;
  }

  @override
  Stream<bool> isRunningNow(String activityUid) {
    final ctrl = _runningCtrls.putIfAbsent(
      activityUid,
          () => StreamController<bool>.broadcast(),
    );
    scheduleMicrotask(() => _notifyRunning(activityUid,
        running: _hasOpenSession(int.tryParse(activityUid) ?? -1)));
    return ctrl.stream;
  }

  @override
  Stream<bool> isPausedNow(String activityUid) {
    final ctrl = _pausedCtrls.putIfAbsent(
      activityUid,
          () => StreamController<bool>.broadcast(),
    );
    final id = int.tryParse(activityUid) ?? -1;
    final paused = _isPaused(id);
    scheduleMicrotask(() => _notifyPaused(activityUid, paused: paused));
    return ctrl.stream;
  }

  @override
  Future<List<DbSession>> listSessionsByActivity(int activityId) async {
    final list =
    _sessions.where((s) => s.activityId == activityId).toList(growable: false);
    list.sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return list;
  }

  @override
  Future<List<DbPause>> listPausesBySession(int sessionId) async {
    final list =
    _pauses.where((p) => p.sessionId == sessionId).toList(growable: false);
    list.sort((a, b) => a.startAt.compareTo(b.startAt));
    return list;
  }

  @override
  Future<int> effectiveMinutesOnDay(int activityId, DateTime date) async {
    final dayStartLocal = DateTime(date.year, date.month, date.day);
    final dayEndLocal = dayStartLocal.add(const Duration(days: 1));
    final start = dayStartLocal.toUtc();
    final end = dayEndLocal.toUtc();

    final sessions = _sessions.where((s) =>
    s.activityId == activityId &&
        s.startedAt.isBefore(end) &&
        ((s.endedAt == null) || (s.endedAt!.isAfter(start))));

    var total = Duration.zero;
    for (final s in sessions) {
      final sEnd = s.endedAt ?? _now();
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
    for (var i = 0; i < days; i++) {
      final d = DateTime.now().subtract(Duration(days: i));
      final key = DateTime(d.year, d.month, d.day);
      map[key] = await effectiveMinutesOnDay(activityId, d);
    }
    return map;
  }

  // ---------- helpers ----------

  bool _hasOpenSession(int activityId) =>
      _sessions.any((s) => s.activityId == activityId && s.endedAt == null);

  bool _isPaused(int activityId) {
    final s = _sessions.firstWhereOrNull(
            (x) => x.activityId == activityId && x.endedAt == null);
    if (s == null) return false;
    final p = _pauses.firstWhereOrNull(
            (p) => p.sessionId == s.id && p.endAt == null);
    return p != null;
  }

  Future<Duration> _totalPausedBetween(
      int sessionId, DateTime from, DateTime to) async {
    final list = _pauses.where((p) =>
    p.sessionId == sessionId &&
        p.startAt.isBefore(to) &&
        ((p.endAt == null) || (p.endAt!.isAfter(from))));
    var total = Duration.zero;
    for (final p in list) {
      final pEnd = p.endAt ?? _now();
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

  void _ensureTicker(String uid) {
    _tickers.putIfAbsent(uid, () {
      return Timer.periodic(const Duration(seconds: 1), (_) => _emitElapsed(uid));
    });
  }

  void _stopTicker(String uid) {
    _tickers.remove(uid)?.cancel();
  }

  void _emitElapsed(String uid) {
    final id = int.tryParse(uid) ?? -1;
    final s = _sessions.firstWhereOrNull(
            (x) => x.activityId == id && x.endedAt == null);
    final ctrl = _elapsedCtrls.putIfAbsent(
        uid, () => StreamController<Duration>.broadcast());

    if (s == null) {
      ctrl.add(Duration.zero);
      return;
    }
    final now = _now();
    final end = s.endedAt ?? now;
    final paused = _pauses.where((p) =>
    p.sessionId == s.id && (p.endAt == null || p.endAt!.isAfter(s.startedAt)));
    var totalPaused = Duration.zero;
    for (final p in paused) {
      final pEnd = p.endAt ?? now;
      totalPaused += _overlapBetween(p.startAt, pEnd, s.startedAt, end);
    }
    var elapsed = end.difference(s.startedAt) - totalPaused;
    if (elapsed.isNegative) elapsed = Duration.zero;
    ctrl.add(elapsed);
  }

  void _notifyRunning(String uid, {required bool running}) {
    final ctrl = _runningCtrls.putIfAbsent(
        uid, () => StreamController<bool>.broadcast());
    ctrl.add(running);
  }

  void _notifyPaused(String uid, {required bool paused}) {
    final ctrl = _pausedCtrls.putIfAbsent(
        uid, () => StreamController<bool>.broadcast());
    ctrl.add(paused);
  }
}
