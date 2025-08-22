import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers_heatmap.dart';

class HeatmapPage extends ConsumerWidget {
  const HeatmapPage({
    super.key,
    required this.activityId,
    this.days = 30,
  });

  final int activityId;
  final int days;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = LastNDaysArgs(activityId: activityId, days: days);
    final asyncMap = ref.watch(lastNDaysMapProvider(args));

    return Scaffold(
      appBar: AppBar(title: const Text('Heatmap')),
      body: asyncMap.when(
        data: (map) {
          // Tri par date décroissante pour l’affichage
          final entries = map.entries.toList()
            ..sort((a, b) => b.key.compareTo(a.key));

          if (entries.isEmpty) {
            return const Center(child: Text('Aucune donnée'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: entries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final e = entries[index];
              final dateStr =
                  "${e.key.year}-${e.key.month.toString().padLeft(2, '0')}-${e.key.day.toString().padLeft(2, '0')}";
              return ListTile(
                title: Text(dateStr),
                trailing: Text('${e.value} min'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Erreur: $err')),
      ),
    );
  }
}
