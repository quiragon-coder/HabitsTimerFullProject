// lib/pages/activity_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/activity.dart';
import '../providers_timer.dart';
import '../widgets/activity_controls.dart';
import '../widgets/mini_heatmap.dart';
import '../widgets/activity_history.dart';

class ActivityDetailPage extends ConsumerWidget {
  const ActivityDetailPage({super.key, required this.activity});
  final Activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Some parts of the app expect a String uid, others an int id.
    // Normalize both here from whatever type `activity.id` currently is.
    final intId = (activity.id is int)
        ? activity.id as int
        : int.tryParse(activity.id.toString()) ?? 0;
    final uid = intId.toString();

    final elapsed = ref.watch(elapsedStreamProvider(uid));

    return Scaffold(
      appBar: AppBar(
        title: Text(activity.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: elapsed.when(
                data: (d) => Text(
                  "${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}",
                ),
                loading: () => const Text("00:00"),
                error: (_, __) => const Text("—"),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Controls need an int
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ActivityControls(activityId: intId),
            ),
          ),
          const SizedBox(height: 12),

          // Mini heatmap needs a String uid + a Color as base
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Statistiques",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  MiniHeatmap(
                    activityUid: uid,
                    days: 30,
                    // If your model exposes `color` directly, this is fine.
                    // If you only have `colorValue` (int), use Color(activity.colorValue).
                    baseColor: activity.color,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // History needs an int
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ActivityHistory(activityId: intId),
            ),
          ),
        ],
      ),
    );
  }
}
