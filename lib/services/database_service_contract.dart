import 'dart:async';
import 'package:flutter/material.dart';

abstract class DatabaseService {
  Stream<List<Activity>> watchActivities();
  Future<Activity> createActivity({
    required String name,
    required String emoji,
    required int colorValue,
    int dailyGoalMinutes = 0,
    int weeklyGoalMinutes = 0,
    int monthlyGoalMinutes = 0,
    int yearlyGoalMinutes = 0,
  });

  Future<void> start(int activityId);
  Future<void> togglePause(int activityId);
  Future<void> stop(int activityId);

  Stream<Duration> runningElapsedNow(String activityUid);
  Stream<bool> isRunningNow(String activityUid);
  Stream<bool> isPausedNow(String activityUid);

  Future<List<DbSession>> listSessionsByActivity(int activityId);
  Future<List<DbPause>> listPausesBySession(int sessionId);

  Future<int> effectiveMinutesOnDay(int activityId, DateTime date);

  Future<Map<DateTime, int>> lastNDaysMap(String activityUid, {required int days});
}

class Activity {
  final int id;
  final String name;
  final String emoji;
  final int colorValue;
  final int dailyGoalMinutes;
  final int weeklyGoalMinutes;
  final int monthlyGoalMinutes;
  final int yearlyGoalMinutes;

  const Activity({
    required this.id,
    required this.name,
    required this.emoji,
    required this.colorValue,
    this.dailyGoalMinutes = 0,
    this.weeklyGoalMinutes = 0,
    this.monthlyGoalMinutes = 0,
    this.yearlyGoalMinutes = 0,
  });

  Color get color => Color(colorValue);
}

class DbSession {
  final int id;
  final int activityId;
  final DateTime startedAt;
  final DateTime? endedAt;

  const DbSession({
    required this.id,
    required this.activityId,
    required this.startedAt,
    required this.endedAt,
  });
}

class DbPause {
  final int id;
  final int sessionId;
  final DateTime startAt;
  final DateTime? endAt;

  const DbPause({
    required this.id,
    required this.sessionId,
    required this.startAt,
    required this.endAt,
  });
}
