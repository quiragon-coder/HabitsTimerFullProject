import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../../../core/db/daos.dart';
import '../../../core/db/database_provider.dart';

enum TimerRunState { idle, running, paused }

@immutable
class ActiveTimerState {
  final TimerRunState state;
  final int activityId;
  final int? sessionId;
  final Duration elapsed;
  final DateTime? startTs;
  final DateTime? pauseStart;
  final bool isBusy;
  final String? error;

  const ActiveTimerState({
    required this.state,
    required this.activityId,
    required this.sessionId,
    required this.elapsed,
    required this.startTs,
    required this.pauseStart,
    this.isBusy = false,
    this.error,
  });

  ActiveTimerState copyWith({
    TimerRunState? state,
    int? activityId,
    int? sessionId,
    Duration? elapsed,
    DateTime? startTs,
    DateTime? pauseStart,
    bool? isBusy,
    String? error,
  }) {
    return ActiveTimerState(
      state: state ?? this.state,
      activityId: activityId ?? this.activityId,
      sessionId: sessionId ?? this.sessionId,
      elapsed: elapsed ?? this.elapsed,
      startTs: startTs ?? this.startTs,
      pauseStart: pauseStart ?? this.pauseStart,
      isBusy: isBusy ?? this.isBusy,
      error: error,
    );
  }

  const ActiveTimerState.initial(int activityId)
      : state = TimerRunState.idle,
        activityId = activityId,
        sessionId = null,
        elapsed = Duration.zero,
        startTs = null,
        pauseStart = null,
        isBusy = false,
        error = null;
}

// Use the Family Notifier API properly
class ActiveTimerController extends AutoDisposeFamilyNotifier<ActiveTimerState, int> {
  Timer? _ticker;

  AppDatabase get _db => ref.read(databaseProvider);
  ActivitiesDao get _activities => _db.activitiesDao;
  SessionsDao get _sessions => _db.sessionsDao;
  PausesDao get _pauses => _db.pausesDao;

  @override
  ActiveTimerState build(int activityId) {
    // Ensure ticker is stopped when provider is disposed
    ref.onDispose(() => _stopTicker());
    return ActiveTimerState.initial(activityId);
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.state == TimerRunState.running) {
        state = state.copyWith(elapsed: state.elapsed + const Duration(seconds: 1));
      }
    });
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  Future<void> play() async {
    if (state.state == TimerRunState.running) return;
    state = state.copyWith(isBusy: true, error: null);
    try {
      final now = DateTime.now();
      final id = await _sessions.startSession(activityId: state.activityId, start: now);
      state = state.copyWith(
        state: TimerRunState.running,
        sessionId: id,
        startTs: now,
        elapsed: Duration.zero,
        pauseStart: null,
        isBusy: false,
      );
      _startTicker();
    } catch (e) {
      state = state.copyWith(isBusy: false, error: e.toString());
    }
  }

  Future<void> pause() async {
    if (state.state != TimerRunState.running) return;
    _stopTicker();
    state = state.copyWith(state: TimerRunState.paused, pauseStart: DateTime.now());
  }

  Future<void> resume() async {
    if (state.state != TimerRunState.paused || state.sessionId == null || state.pauseStart == null) return;
    state = state.copyWith(isBusy: true, error: null);
    try {
      final now = DateTime.now();
      await _pauses.addPause(sessionId: state.sessionId!, start: state.pauseStart!, end: now);
      state = state.copyWith(state: TimerRunState.running, pauseStart: null, isBusy: false);
      _startTicker();
    } catch (e) {
      state = state.copyWith(isBusy: false, error: e.toString());
    }
  }

  Future<void> stop() async {
    if (state.sessionId == null) return;
    state = state.copyWith(isBusy: true, error: null);
    try {
      final now = DateTime.now();
      await _sessions.stopSession(sessionId: state.sessionId!, end: now);
      _stopTicker();
      state = ActiveTimerState.initial(state.activityId);
    } catch (e) {
      state = state.copyWith(isBusy: false, error: e.toString());
    }
  }
}

// Correct provider type for Family Notifier
final activeTimerControllerProvider = AutoDisposeNotifierProviderFamily<ActiveTimerController, ActiveTimerState, int>(
  ActiveTimerController.new,
);
