import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habits_timer/providers_stats.dart';

class ActivityStatsPanel extends ConsumerWidget {
  final String activityId;
  final int lastDays; // pour la section "derniers N jours"

  const ActivityStatsPanel({
    super.key,
    required this.activityId,
    this.lastDays = 30,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(minutesTodayProvider(activityId));
    final week = ref.watch(minutesThisWeekProvider(activityId));
    final month = ref.watch(minutesThisMonthProvider(activityId));
    final year = ref.watch(minutesThisYearProvider(activityId));

    final lastNDays = ref.watch(
      lastNDaysProvider(
        LastNDaysArgs(activityId: activityId, days: lastDays),
      ),
    );

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Statistiques', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatChip(label: 'Aujourd\'hui', value: today),
                _StatChip(label: 'Semaine', value: week),
                _StatChip(label: 'Mois', value: month),
                _StatChip(label: 'Année', value: year),
              ],
            ),

            const SizedBox(height: 16),
            Text('Derniers $lastDays jours', style: Theme.of(context).textTheme.titleMedium),

            lastNDays.when(
              data: (list) {
                final total = list.fold<int>(0, (sum, d) => sum + d.minutes);
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text('Total: $total min'),
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.only(top: 8),
                child: LinearProgressIndicator(),
              ),
              error: (e, st) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Erreur: $e'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final AsyncValue<int> value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (v) => Chip(label: Text('$label: ${v}m')),
      loading: () => const Chip(label: Text('...')),
      error: (e, st) => Chip(label: Text('$label: -')),
    );
  }
}
