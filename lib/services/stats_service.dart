import 'dart:math';

// Si tu as déjà ces types dans ton projet, garde les tiens et supprime
// ces classes. Ici on les déclare légères pour être indépendants.
class DbSession {
  final int id;
  final DateTime startAt;
  final DateTime? endAt;

  DbSession({required this.id, required this.startAt, this.endAt});
}

class DbPause {
  final int id;
  final int sessionId;
  final DateTime startAt;
  final DateTime? endAt;

  DbPause({
    required this.id,
    required this.sessionId,
    required this.startAt,
    this.endAt,
  });
}

/// Service de calcul des stats (minutes, heatmap…)
class StatsService {
  StatsService(this.db);
  final dynamic db; // ton DatabaseService concret

  // ---------- Helpers temps ----------
  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);
  DateTime _endOfDay(DateTime d) => DateTime(d.year, d.month, d.day).add(const Duration(days: 1));

  DateTime _startOfWeek(DateTime d) {
    final int w = d.weekday; // Lundi=1
    final delta = Duration(days: w - DateTime.monday);
    return _startOfDay(d.subtract(delta));
  }

  DateTime _startOfMonth(DateTime d) => DateTime(d.year, d.month, 1);
  DateTime _startOfYear(DateTime d) => DateTime(d.year, 1, 1);

  Duration _overlap(DateTime aStart, DateTime aEnd, DateTime bStart, DateTime bEnd) {
    final start = aStart.isAfter(bStart) ? aStart : bStart;
    final end = aEnd.isBefore(bEnd) ? aEnd : bEnd;
    if (!end.isAfter(start)) return Duration.zero;
    return end.difference(start);
  }

  // ---------- Accès DB attendus ----------
  Future<List<DbSession>> _sessions(String activityId) async {
    // Adapte au nom réel de ta méthode si besoin :
    final raw = await db.listSessionsByActivityUid(activityId);
    return raw.cast<DbSession>();
  }

  Future<List<DbPause>> _pauses(String activityId, int sessionId) async {
    // Adapte au nom réel de ta méthode si besoin :
    final raw = await db.listPausesBySession(activityId, sessionId);
    return raw.cast<DbPause>();
  }

  // ---------- Calculs ----------
  /// Minutes efficaces sur une journée (pauses déduites).
  Future<int> minutesOnDay(String activityId, DateTime day) async {
    final dayStart = _startOfDay(day);
    final dayEnd = _endOfDay(day);

    final sessions = await _sessions(activityId);
    int totalSeconds = 0;

    for (final s in sessions) {
      final sStart = s.startAt;
      final sEnd = s.endAt ?? DateTime.now();
      final overlapDur = _overlap(sStart, sEnd, dayStart, dayEnd);
      if (overlapDur == Duration.zero) continue;

      // Déduire les pauses qui chevauchent la même fenêtre
      final pauses = await _pauses(activityId, s.id);
      int pausedSeconds = 0;
      for (final p in pauses) {
        final pStart = p.startAt;
        final pEnd = p.endAt ?? DateTime.now();
        final pOverlap = _overlap(pStart, pEnd, dayStart, dayEnd);
        pausedSeconds += pOverlap.inSeconds;
      }

      final eff = max(0, overlapDur.inSeconds - pausedSeconds);
      totalSeconds += eff;
    }
    return (totalSeconds / 60).floor();
  }

  /// Minutes par jour pour les `days` derniers jours (clé = date locale à minuit).
  Future<Map<DateTime, int>> lastNDays(String activityId, {required int days}) async {
    final now = DateTime.now();
    final Map<DateTime, int> out = {};
    for (int i = days - 1; i >= 0; i--) {
      final d = _dateOnly(now.subtract(Duration(days: i)));
      out[d] = await minutesOnDay(activityId, d);
    }
    return out;
  }

  Future<int> minutesInRange(String activityId, DateTime start, DateTime end) async {
    int total = 0;
    DateTime cursor = _startOfDay(start);
    final endDay = _startOfDay(end);
    while (!cursor.isAfter(endDay)) {
      total += await minutesOnDay(activityId, cursor);
      cursor = cursor.add(const Duration(days: 1));
    }
    return total;
  }

  Future<int> minutesToday(String activityId) async {
    final d = _dateOnly(DateTime.now());
    return minutesOnDay(activityId, d);
  }

  Future<int> minutesThisWeek(String activityId) async {
    final start = _startOfWeek(DateTime.now());
    return minutesInRange(activityId, start, DateTime.now());
  }

  Future<int> minutesThisMonth(String activityId) async {
    final start = _startOfMonth(DateTime.now());
    return minutesInRange(activityId, start, DateTime.now());
  }

  Future<int> minutesThisYear(String activityId) async {
    final start = _startOfYear(DateTime.now());
    return minutesInRange(activityId, start, DateTime.now());
  }

  /// ⬅️ Version MAP demandée par tes providers/écrans heatmap
  Future<Map<DateTime, int>> dailyMinutesRange(
      String activityId, {
        required DateTime from,
        required DateTime to,
      }) async {
    final Map<DateTime, int> m = {};
    DateTime cursor = _startOfDay(from);
    final endDay = _startOfDay(to);
    while (!cursor.isAfter(endDay)) {
      m[cursor] = await minutesOnDay(activityId, cursor);
      cursor = cursor.add(const Duration(days: 1));
    }
    return m;
  }
}
