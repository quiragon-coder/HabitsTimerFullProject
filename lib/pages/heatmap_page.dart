// lib/pages/heatmap_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers_heatmap.dart';

class HeatmapPage extends ConsumerWidget {
  const HeatmapPage({
    super.key,
    required this.activityId,
    this.days = 120,
  });

  final String activityId;
  final int days;

  static const int _cols = 14; // largeur de la grille (ajuste si tu veux)

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final from =
    DateTime(today.year, today.month, today.day).subtract(Duration(days: days - 1));
    final to = DateTime(today.year, today.month, today.day);

    final asyncMap = ref.watch(
      heatmapProvider(HeatmapArgs(activityId: activityId, from: from, to: to)),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Heatmap')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: asyncMap.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Erreur: $e')),
          data: (map) {
            final dates = map.keys.toList()..sort();
            final values = map.values.toList();
            final maxVal = values.isEmpty ? 0 : values.reduce(max);

            Color cellColor(int v) {
              if (maxVal <= 0) {
                return Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withValues(alpha: 0.15);
              }
              final t = v / maxVal;
              final alpha = 0.15 + 0.75 * t;
              return Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: alpha);
            }

            final rows = (dates.length / _cols).ceil();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Du ${from.day}/${from.month} au ${to.day}/${to.month}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: rows * 16.0,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _cols,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: dates.length,
                    itemBuilder: (context, i) {
                      final d = dates[i];
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
