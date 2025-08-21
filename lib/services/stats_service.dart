import 'database_service_contract.dart';

class StatsService {
  StatsService(this.db);
  final DatabaseService db;

  Future<int> minutesToday(int activityId) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    return effectiveBetween(activityId, start, now);
  }
  Future<int> minutesThisWeek(int activityId) async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: (now.weekday % 7)));
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    return effectiveBetween(activityId, start, now);
  }
  Future<int> minutesThisMonth(int activityId) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    return effectiveBetween(activityId, start, now);
  }
  Future<int> minutesThisYear(int activityId) async {
    final now = DateTime.now();
    final start = DateTime(now.year, 1, 1);
    return effectiveBetween(activityId, start, now);
  }

  Future<int> effectiveBetween(int activityId, DateTime from, DateTime to) async {
    int total = 0;
    for (DateTime d = DateTime(from.year, from.month, from.day);
         d.isBefore(to) || _sameDay(d, to);
         d = d.add(const Duration(days: 1))) {
      total += await db.effectiveMinutesOnDay(activityId, d);
    }
    return total;
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Future<Map<DateTime, int>> lastNDaysMap(int activityId, {required int days}) {
    return db.lastNDaysMap(activityId.toString(), days: days);
  }
}
