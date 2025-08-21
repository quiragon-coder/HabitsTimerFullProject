import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/activity.dart';
import '../providers.dart';
import '../providers_timer.dart';

import '../widgets/activity_controls.dart';
import '../widgets/elapsed_badge.dart';
import '../widgets/activity_stats_panel.dart';
import '../widgets/mini_heatmap.dart';
import '../widgets/activity_history.dart';

class ActivityDetailPage extends ConsumerStatefulWidget {
  const ActivityDetailPage({
    super.key,
    required this.activity,
  });

  final Activity activity;

  @override
  ConsumerState<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends ConsumerState<ActivityDetailPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Center(
              child: ElapsedBadge(activityId: widget.activity.id),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Contrôles
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ActivityControls(
                activityId: widget.activity.id,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Historique
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ActivityHistory(
                activityId: widget.activity.id,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Statistiques
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ActivityStatsPanel(
                activityId: widget.activity.id,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Mini heatmap
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: MiniHeatmap(
                activityId: widget.activity.id,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
