import 'dart:async';
import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../models/session.dart';
import '../models/pause.dart';
import '../models/stats.dart';

/// Service en mémoire (remplace temporairement Isar).
class DatabaseService {
  DatabaseService();

  final List<Activity> _activities = [];
  final List<Session> _sessions = [];
  final List<Pause> _pauses = [];

  // ------ Activities ------
  Stream<List<Activity>> watchActivities() async* {
    while (true) {
      yield List<Activity>.unmodifiable(_activities);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

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
      id: UniqueKey().hashCode.toString(),
      name: name,
      emoji: emoji,
      colorValue: colorValue,
    );
    _activities.add(a);
    return a;
  }

  // ------ Timer state ------
  bool isRunningNow({required String activityId}) =>
      _sessions.any((s) => s.activityId == activityId && s.endedAt == null);

  bool isPausedNow({required String activityId}) {
    final s = _sessions.lastWhere(
          (s) => s.activityId == activityId && s.endedAt == null,
      orElse: () => Session(id: '', activityId: '', startedAt: DateTime(0)),
    );
    if (s.id.isEmpty) return false;
    return _pauses.any((p) => p.sessionId == s.id && p.endedAt == null);
  }

  Duration runningElapsedNow({required String activityId}) {
    final s = _sessions.lastWhere(
          (s) => s.activityId == activityId && s.endedAt == null,
      orElse: () => Session(id: '', activityId: '', startedAt: DateTime(0)),
    );
    if (s.id.isEmpty) return Duration.zero;
    final now = DateTime.now();
    var total = now.difference(s.startedAt);
    final pauses = _pauses.where((p) => p.sessionId == s.id);
    for (final p in pauses) {
      final end = p.endedAt ?? now;
      total -= end.difference(p.startedAt);
    }
    return total.isNegative ? Duration.zero : total;
  }

  Future<void> start({required String activityId}) async {
    if (isRunningNow(activityId: activityId)) return;
    _sessions.add(Session(
      id: UniqueKey().hashCode.toString(),
      activityId: activityId,
      startedAt: DateTime.now(),
    ));
  }

  Future<void> togglePause({required String activityId}) async {
    if (!isRunningNow(activityId: activityId)) return;
    final s = _sessions.lastWhere((s) => s.activityId == activityId && s.endedAt == null);
    final openPause = _pauses.lastWhere(
          (p) => p.sessionId == s.id && p.endedAt == null,
      orElse: () => Pause(id: '', sessionId: '', startedAt: DateTime(0)),
    );
    if (openPause.id.isEmpty) {
      _pauses.add(Pause(
        id: UniqueKey().hashCode.toString(),
        sessionId: s.id,
        startedAt: DateTime.now(),
      ));
    } else {
      openPause.endedAt = DateTime.now();
    }
  }

  Future<void> stop({required String activityId}) async {
    if (!isRunningNow(activityId: activityId)) return;
    final s = _sessions.lastWhere((s) => s.activityId == activityId && s.endedAt == null);
    final openPause = _pauses.lastWhere(
          (p) => p.sessionId == s.id && p.endedAt == null,
      orElse: () => Pause(id: '', sessionId: '', startedAt: DateTime(0)),
    );
    if (openPause.id.isNotEmpty) {
      openPause.endedAt = DateTime.now();
    }
    s.endedAt = DateTime.now();
  }

  // ------ Queries ------
  Future<List<Session>> listSessionsByActivity(String activityId) async {
    final list = _sessions.where((s) => s.activityId == activityId).toList()
      ..sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return list;
  }

  Future<List<Pause>> listPausesBySession(String sessionId) async {
    final list = _pauses.where((p) => p.sessionId == sessionId).toList()
      ..sort((a, b) => a.startedAt.compareTo(b.startedAt));
    return list;
  }

  Duration effectiveDurationFor(Session s) {
    final end = s.endedAt ?? DateTime.now();
    var total = end.difference(s.startedAt);
    final pauses = _pauses.where((p) => p.sessionId == s.id);
    for (final p in pauses) {
      final pEnd = p.endedAt ?? end;
      total -= pEnd.difference(p.startedAt);
    }
    return total.isNegative ? Duration.zero : total;
  }

  Future<int> effectiveMinutesOnDay(String activityId, DateTime day) async {
    final startDay = DateTime(day.year, day.month, day.day);
    final endDay = startDay.add(const Duration(days: 1));
    int minutes = 0;
    final sessions = await listSessionsByActivity(activityId);
    for (final s in sessions) {
      final sStart = s.startedAt;
      final sEnd = s.endedAt ?? DateTime.now();
      final overlapStart = sStart.isAfter(startDay) ? sStart : startDay;
      final overlapEnd = sEnd.isBefore(endDay) ? sEnd : endDay;
      if (!overlapEnd.isAfter(overlapStart)) continue;

      var dur = overlapEnd.difference(overlapStart);
      final pauses = _pauses.where((p) => p.sessionId == s.id);
      for (final p in pauses) {
        final pStart = p.startedAt;
        final pEnd = p.endedAt ?? sEnd;
        final poStart = pStart.isAfter(startDay) ? pStart : startDay;
        final poEnd = pEnd.isBefore(endDay) ? pEnd : endDay;
        if (poEnd.isAfter(poStart)) {
          dur -= poEnd.difference(poStart);
        }
      }
      minutes += dur.inMinutes;
    }
    return minutes;
  }

  Future<List<int>> dailyMinutesRange(String activityId, {required int days}) async {
    final now = DateTime.now();
    final List<int> out = [];
    for (int i = 0; i < days; i++) {
      final d = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      out.add(await effectiveMinutesOnDay(activityId, d));
    }
    return out;
  }

  Future<List<DailyStat>> lastNDays(String activityId, {required int days}) async {
    final now = DateTime.now();
    final List<DailyStat> out = [];
    for (int i = 0; i < days; i++) {
      final d = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      final m = await effectiveMinutesOnDay(activityId, d);
      out.add(DailyStat(d, m));
    }
    return out;
  }

  Future<List<HourlyBucket>> hourlyToday(String activityId) async {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = start.add(const Duration(days: 1));
    final buckets = List<int>.filled(24, 0);

    final sessions = await listSessionsByActivity(activityId);
    for (final s in sessions) {
      final sStart = s.startedAt;
      final sEnd = s.endedAt ?? DateTime.now();
      DateTime segStart = sStart.isAfter(start) ? sStart : start;
      DateTime segEnd = sEnd.isBefore(end) ? sEnd : end;
      if (!segEnd.isAfter(segStart)) continue;

      final pauses = _pauses.where((p) => p.sessionId == s.id);
      final segments = <DateTime>[];
      segments.add(segStart);
      for (final p in pauses) {
        final pStart = p.startedAt;
        final pEnd = p.endedAt ?? sEnd;
        if (pEnd.isAfter(segStart) && pStart.isBefore(segEnd)) {
          if (pStart.isAfter(segStart)) segments.add(pStart);
          if (pEnd.isBefore(segEnd)) segments.add(pEnd);
        }
      }
      segments.add(segEnd);
      segments.sort();

      for (int i = 0; i < segments.length - 1; i += 2) {
        final a = segments[i];
        final b = segments[i + 1];
        _accumulateByHour(a, b, buckets);
      }
    }

    return [for (int h = 0; h < 24; h++) HourlyBucket(h, buckets[h])];
  }

  void _accumulateByHour(DateTime a, DateTime b, List<int> buckets) {
    DateTime cur = a;
    while (cur.isBefore(b)) {
      final nextHour = DateTime(cur.year, cur.month, cur.day, cur.hour).add(const Duration(hours: 1));
      final end = b.isBefore(nextHour) ? b : nextHour;
      buckets[cur.hour] += end.difference(cur).inMinutes;
      cur = end;
    }
  }
}
