import 'package:flutter/material.dart';

class MiniHeatmap extends StatelessWidget {
  const MiniHeatmap({super.key, required this.activityId, this.days = 30});

  final int activityId;
  final int days;

  @override
  Widget build(BuildContext context) {
    final boxCount = days;
    final cols = 10;
    final rows = (boxCount / cols).ceil();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
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
                  crossAxisCount: 10,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: boxCount,
                itemBuilder: (context, i) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
