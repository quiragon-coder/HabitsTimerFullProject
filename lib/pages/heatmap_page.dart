import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habits_timer/providers_stats.dart';
import 'package:habits_timer/models/stats.dart';

class HeatmapPage extends ConsumerWidget {
  final String activityId;
  final int days;

  const HeatmapPage({
    super.key,
    required this.activityId,
    this.days = 90, // par défaut 90 jours
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(
      lastNDaysProvider(
        LastNDaysArgs(activityId: activityId, days: days),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique'),
      ),
      body: asyncStats.when(
        data: (List<DailyStat> list) {
          if (list.isEmpty) {
            return const Center(child: Text('Aucune donnée pour cette période.'));
          }
          // Simple liste en attendant un heatmap visuel
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final d = list[index];
              return ListTile(
                leading: Text(
                  '${d.date.year}-${d.date.month.toString().padLeft(2, '0')}-${d.date.day.toString().padLeft(2, '0')}',
                ),
                trailing: Text('${d.minutes} min'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Erreur : $err'),
        ),
      ),
    );
  }
}
