// lib/pages/heatmap_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers_stats.dart';
import '../widgets/heatmap.dart';

class HeatmapPage extends ConsumerWidget {
  const HeatmapPage({super.key, required this.activityId});
  final int activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = LastNDaysArgs(activityUid: activityId.toString(), days: 120);
    final asyncMap = ref.watch(lastNDaysMapProvider(args));

    return Scaffold(
      appBar: AppBar(title: const Text("Heatmap")),
      body: asyncMap.when(
        data: (map) => Padding(
          padding: const EdgeInsets.all(16),
          child: Heatmap(data: map, baseColor: Theme.of(context).colorScheme.primary),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Erreur: $e")),
      ),
    );
  }
}
