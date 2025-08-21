import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/activity.dart';
import '../widgets/elapsed_badge.dart';
import '../widgets/activity_controls.dart';
import '../widgets/mini_heatmap.dart';
import '../widgets/activity_stats_panel.dart';

class ActivityDetailPage extends ConsumerWidget {
  const ActivityDetailPage({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = activity.color;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(activity.emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Flexible(child: Text(activity.name, overflow: TextOverflow.ellipsis)),
          ],
        ),
        backgroundColor: color.withValues(alpha: 0.1),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElapsedBadge(activityId: activity.id),
              ActivityControls(activityId: activity.id),
            ],
          ),
          const SizedBox(height: 16),
          ActivityStatsPanel(activityId: activity.id),
          const SizedBox(height: 16),
          MiniHeatmap(activityId: activity.id, days: 30),
        ],
      ),
    );
  }
}
