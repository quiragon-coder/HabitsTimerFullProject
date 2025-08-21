import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers_stats.dart';
import 'services/stats_service.dart';

class HeatmapArgs {
  final String activityId;
  final DateTime from;
  final DateTime to;

  const HeatmapArgs({
    required this.activityId,
    required this.from,
    required this.to,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HeatmapArgs &&
              runtimeType == other.runtimeType &&
              activityId == other.activityId &&
              from == other.from &&
              to == other.to;

  @override
  int get hashCode => Object.hash(activityId, from, to);
}

/// Map<DateTime, int> pour alimenter la heatmap
final heatmapProvider =
FutureProvider.family<Map<DateTime, int>, HeatmapArgs>((ref, args) async {
  final StatsService stats = ref.read(statsProvider);
  return stats.dailyMinutesRange(
    args.activityId, // <- positionnel
    from: args.from,
    to: args.to,
  );
});
