import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers_stats.dart';

class ActivityStatsPanel extends ConsumerWidget {
  const ActivityStatsPanel({super.key, required this.activityId});

  final String activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today  = ref.watch(minutesTodayProvider(activityId));
    final week   = ref.watch(minutesThisWeekProvider(activityId));
    final month  = ref.watch(minutesThisMonthProvider(activityId));
    final year   = ref.watch(minutesThisYearProvider(activityId));

    Widget tile(String label, AsyncValue<int> v) {
      return v.when(
        data: (m) => _StatChip(label: label, minutes: m),
        loading: () => const _StatChip(label: '…', minutes: null),
        error: (_, __) => const _StatChip(label: '—', minutes: null),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            tile('Aujourd\'hui', today),
            tile('Semaine', week),
            tile('Mois', month),
            tile('Année', year),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.minutes});

  final String label;
  final int? minutes;

  @override
  Widget build(BuildContext context) {
    final text = minutes == null ? '—' : '${minutes}m';
    return Chip(
      label: Text('$label: $text'),
      backgroundColor:
      Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.25),
    );
  }
}
