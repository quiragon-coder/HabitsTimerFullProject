import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers_timer.dart';

class HistoryTodayCard extends ConsumerWidget {
  const HistoryTodayCard({
    super.key,
    required this.activityId,
  });

  final int activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);
    final today = DateTime.now();

    return FutureBuilder<int>(
      future: db.effectiveMinutesOnDay(activityId, today),
      builder: (context, snap) {
        final minutes = snap.data ?? 0;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.today_rounded),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Aujourd’hui',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text('$minutes min'),
              ],
            ),
          ),
        );
      },
    );
  }
}
