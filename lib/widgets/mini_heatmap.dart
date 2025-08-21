// lib/widgets/mini_heatmap.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers_stats.dart';
import 'heatmap.dart';

class MiniHeatmap extends ConsumerWidget {
  const MiniHeatmap({
    super.key,
    required this.activityUid,
    this.days = 30,
    required this.baseColor,
  });

  final String activityUid;
  final int days;
  final Color baseColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = LastNDaysArgs(activityUid: activityUid, days: days);
    final asyncMap = ref.watch(lastNDaysMapProvider(args));

    return asyncMap.when(
      data: (map) => Heatmap(data: map, baseColor: baseColor),
      loading: () => const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) =>
          SizedBox(height: 120, child: Center(child: Text("Erreur: $e"))),
    );
  }
}
