import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/activity.dart';
import '../widgets/activity_controls.dart';
import '../widgets/elapsed_badge.dart';
import 'activity_detail_page.dart';

class ActivitiesListPage extends ConsumerStatefulWidget {
  const ActivitiesListPage({super.key});

  @override
  ConsumerState<ActivitiesListPage> createState() => _ActivitiesListPageState();
}

class _ActivitiesListPageState extends ConsumerState<ActivitiesListPage> {
  // temporaire – remplace par ton provider d'activités
  final _sample = const <Activity>[];

  @override
  Widget build(BuildContext context) {
    final activities = _sample;

    return Scaffold(
      appBar: AppBar(title: const Text('Mes activités')),
      body: activities.isEmpty
          ? const Center(child: Text('Aucune activité pour le moment'))
          : ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: activities.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final a = activities[i];
          final color = Color(a.colorValue);
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Text(a.emoji),
              ),
              title: Text(a.name),
              subtitle: Row(children: [ElapsedBadge(activityId: a.id)]),
              trailing: ActivityControls(activityId: a.id),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ActivityDetailPage(activity: a),
                ));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: créer une activité
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
