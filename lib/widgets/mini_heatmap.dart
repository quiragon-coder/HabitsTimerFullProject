import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:habits_timer/providers_stats.dart';

class MiniHeatmap extends ConsumerWidget {
  final String activityId;
  final int days;

  const MiniHeatmap({
    super.key,
    required this.activityId,
    this.days = 30,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(
      lastNDaysProvider(
        LastNDaysArgs(activityId: activityId, days: days),
      ),
    );

    return asyncStats.when(
      data: (list) {
        // Représentation ultra simple: une ligne de petits carrés,
        // l’opacité (ou intensité) refletant les minutes.
        final max = (list.map((e) => e.minutes).fold<int>(0, (a, b) => a > b ? a : b)).clamp(1, 999999);
        return SizedBox(
          height: 24,
          child: Row(
            children: [
              for (final d in list)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.green.withOpacity(d.minutes / max),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      loading: () => const SizedBox(
        height: 24,
        child: Center(child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))),
      ),
      error: (e, st) => Text('Erreur: $e'),
    );
  }
}
