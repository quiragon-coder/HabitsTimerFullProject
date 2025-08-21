// lib/providers_heatmap.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers_stats.dart';

/// Re-exports a map provider for heatmaps (date → minutes).
final heatmapDataProvider =
FutureProvider.family<Map<DateTime, int>, LastNDaysArgs>((ref, args) {
  return ref.read(lastNDaysMapProvider(args).future);
});
