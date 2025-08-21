import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/database_service_contract.dart';
import '../providers/providers_timer.dart';
import '../widgets/elapsed_badge.dart';
import '../widgets/activity_controls.dart';
import '../widgets/mini_heatmap.dart';
import 'activity_history_page.dart';

class ActivityDetailPage extends ConsumerWidget {
  const ActivityDetailPage({super.key, required this.activity});
  final Activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intId = activity.id;
    final uid = intId.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('${activity.emoji} ${activity.name}'),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Center(child: ElapsedBadge(activityId: intId)),
        )],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Contrôles', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ActivityControls(activityId: intId),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Heatmap (30 jours)', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  MiniHeatmap(activityUid: uid, days: 30, baseColor: activity.color),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Voir l’historique'),
              subtitle: const Text('Sessions et pauses'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ActivityHistoryPage(activityId: intId, activityName: activity.name),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
