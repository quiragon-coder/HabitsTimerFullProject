import 'package:flutter/material.dart';

/// Heatmap 30 derniers jours, sans dépendance externe.
/// Passe un [countsByDay] (date -> intensité). 0/absent = case pâle.
/// Si tu as une Future/Stream côté data, résous-la en amont et passe ici une Map.
class MiniHeatmap30d extends StatelessWidget {
  const MiniHeatmap30d({
    super.key,
    required this.countsByDay,
    this.title = 'Heatmap (30 jours)',
  });

  final Map<DateTime, int> countsByDay;
  final String title;

  Color _color(BuildContext context, int v) {
    final base = Theme.of(context).colorScheme.primary;
    if (v <= 0) return base.withOpacity(0.08);
    if (v < 3) return base.withOpacity(0.25);
    if (v < 6) return base.withOpacity(0.45);
    if (v < 10) return base.withOpacity(0.65);
    return base.withOpacity(0.85);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day).subtract(const Duration(days: 29));
    final days = List.generate(30, (i) => start.add(Duration(days: i)));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, c) {
                // 6 colonnes x 5 lignes pour 30 jours
                final cell = ((c.maxWidth - 24) / 6).clamp(12, 28);
                return Center(
                  child: SizedBox(
                    width: cell * 6,
                    height: cell * 5,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemCount: days.length,
                      itemBuilder: (context, i) {
                        final d = days[i];
                        final key = DateTime(d.year, d.month, d.day);
                        final v = countsByDay[key] ?? 0;
                        return Tooltip(
                          message: '${d.day}/${d.month} : $v',
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: _color(context, v),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            if (countsByDay.isEmpty) ...[
              const SizedBox(height: 8),
              Text('Aucune donnée récente', style: Theme.of(context).textTheme.bodySmall),
            ]
          ],
        ),
      ),
    );
  }
}
