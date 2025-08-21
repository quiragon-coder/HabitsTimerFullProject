class DailyStat {
  final DateTime date;
  final int minutes;
  const DailyStat(this.date, this.minutes);
}

class HourlyBucket {
  final int hour; // 0-23
  final int minutes;
  const HourlyBucket(this.hour, this.minutes);
}
