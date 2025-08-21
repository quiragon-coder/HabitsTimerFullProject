// ignore_for_file: one_member_abstracts

import 'dart:async';
import 'package:flutter/material.dart';

abstract class DatabaseService {
  // Activities
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

  // Timer controls (IDs en int)
  Future<void> start(int activityId);
  Future<void> togglePause(int activityId);
  Future<void> stop(int activityId);

  // State streams (clés en String)
  Stream<Duration> runningElapsedNow(String activityUid);
  Stream<bool> isRunningNow(String activityUid);
  Stream<bool> isPausedNow(String activityUid);

  // History & stats
  Future<List<DbSession>> listSessionsByActivity(int activityId);
  Future<List<DbPause>> listPausesBySession(int sessionId);

  // Stats de base
  Future<int> effectiveMinutesOnDay(int activityId, DateTime date);

  // Heatmap : map [jour => minutes]
  Future<Map<DateTime, int>> lastNDaysMap(String activityUid, {required int days});
}

class Activity {
  final int id;              // Isar Id
  final String name;
  final String emoji;
  final int colorValue;      // ARGB
  Color get color => Color(colorValue);

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
