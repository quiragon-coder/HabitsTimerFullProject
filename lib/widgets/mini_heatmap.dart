import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers_stats.dart';

class MiniHeatmap extends ConsumerWidget {
  const MiniHeatmap({super.key, required this.activityId, this.days = 30});

  final String activityId; // UID String
  final int days;

  static const int _cols = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(
      lastNDaysProvider(LastNDaysArgs(activityId: activityId, days: days)),
    );

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: data.when(
          loading: () => const SizedBox(
            height: 64,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => const Text('Impossible de charger la heatmap'),
          data: (map) {
            final boxCount = days;
            final rows = (boxCount / _cols).ceil();

            final values = map.values.toList();
            final maxVal = values.isEmpty ? 0 : values.reduce(max);

            Color cellColor(int v) {
              if (maxVal <= 0) {
                return Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withValues(alpha: 0.15);
              }
              // alpha entre 0.15 et 0.9 en fonction de l’intensité
              final t = v / maxVal;
              final alpha = 0.15 + 0.75 * t;
              return Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: alpha);
            }

            // afficher de gauche (ancien) à droite (récent)
            final today = DateTime.now();
            final start = DateTime(today.year, today.month, today.day)
                .subtract(Duration(days: days - 1));

            List<DateTime> seq = List.generate(
              days,
                  (i) => DateTime(start.year, start.month, start.day).add(Duration(days: i)),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Derniers jours',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                SizedBox(
                  height: rows * 14.0,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _cols,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: seq.length,
                    itemBuilder: (context, i) {
                      final d = DateTime(seq[i].year, seq[i].month, seq[i].day);
                      final minutes = map[d] ?? 0;
                      return Tooltip(
                        message: '${d.day}/${d.month}: ${minutes}m',
                        child: Container(
                          decoration: BoxDecoration(
                            color: cellColor(minutes),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
