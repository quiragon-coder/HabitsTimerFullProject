import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers_heatmap.dart';

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
    final mapAsync = ref.watch(lastNDaysMapProvider(LastNDaysArgs(activityId: int.parse(activityUid), days: days)));
    return mapAsync.when(
      loading: () => const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
      error: (e, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Erreur heatmap: $e'),
      ),
      data: (map) {
        if (map.isEmpty) return const Padding(padding: EdgeInsets.all(16), child: Text('Pas encore de données.'));
        final keys = map.keys.toList()..sort();
        final maxVal = map.values.fold<int>(0, (p, n) => n > p ? n : p);
        Color shade(int v) {
          if (maxVal == 0) return baseColor.withOpacity(0.1);
          final t = (v / maxVal).clamp(0.15, 1.0);
          return baseColor.withOpacity(t);
        }
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 4, runSpacing: 4,
            children: [
              for (final d in keys)
                Tooltip(
                  message: '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')} : ${map[d]} min',
                  child: Container(
                    width: 12, height: 12,
                    decoration: BoxDecoration(
                      color: shade(map[d] ?? 0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
