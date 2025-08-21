// lib/providers_stats.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/stats_service.dart';

class LastNDaysArgs {
  final String activityUid;
  final int days;
  const LastNDaysArgs({required this.activityUid, required this.days});
}

final lastNDaysMapProvider =
FutureProvider.family<Map<DateTime, int>, LastNDaysArgs>((ref, args) {
  final s = ref.read(statsProvider);
  return s.lastNDaysMap(args.activityUid, days: args.days);
});
