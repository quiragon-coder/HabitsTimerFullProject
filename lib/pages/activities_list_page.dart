import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers_timer.dart';
import '../services/database_service_contract.dart';
import 'create_activity_page.dart';
import 'activity_detail_page.dart';

class ActivitiesListPage extends ConsumerWidget {
  const ActivitiesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Habits Timer')),
      body: StreamBuilder<List<Activity>>(
        stream: db.watchActivities(),
        builder: (context, snap) {
          final activities = snap.data ?? const <Activity>[];
          if (activities.isEmpty) {
            return const Center(
              child: Text('Aucune activité.
Appuie sur + pour en créer une.', textAlign: TextAlign.center),
            );
          }
          return ListView.separated(
            itemCount: activities.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final a = activities[i];
              return ListTile(
                leading: CircleAvatar(backgroundColor: a.color, child: Text(a.emoji)),
                title: Text(a.name),
                subtitle: Text('ID: ${a.id}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ActivityDetailPage(activity: a),
                  ));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CreateActivityPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
