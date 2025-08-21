// lib/models/stats.dart

/// Stat agrégée par jour (utilisée par les graphiques + pages de détail)
class DailyStat {
  /// Jour « tronqué » à minuit (année/mois/jour ; heure/min/sec = 0)
  final DateTime date;

  /// Minutes efficaces pour ce jour
  final int minutes;

  const DailyStat({
    required this.date,
    required this.minutes,
  });

  DailyStat copyWith({
    DateTime? date,
    int? minutes,
  }) =>
      DailyStat(
        date: date ?? this.date,
        minutes: minutes ?? this.minutes,
      );
}

/// Bucket horaire (0..23) -> minutes efficaces
class HourlyBucket {
  /// Heure de la journée (0..23)
  final int hour;

  /// Minutes efficaces pendant cette heure
  final int minutes;

  const HourlyBucket({
    required this.hour,
    required this.minutes,
  });
}
