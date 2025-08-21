import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/activity.dart';
import '../providers.dart';
import '../widgets/activity_controls.dart';
import 'activity_detail_page.dart';
import 'create_activity_page.dart';

class ActivitiesListPage extends ConsumerStatefulWidget {
  const ActivitiesListPage({super.key});

  @override
  ConsumerState<ActivitiesListPage> createState() => _ActivitiesListPageState();
}

class _ActivitiesListPageState extends ConsumerState<ActivitiesListPage> {
  @override
  Widget build(BuildContext context) {
    final activitiesAsync = ref.watch(activitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes activités'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await Navigator.of(context).push<bool>(
            MaterialPageRoute(builder: (_) => const CreateActivityPage()),
          );
          // le provider est basé sur ChangeNotifier => pas besoin de setState
          if (created == true && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Activité créée')),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: activitiesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur : $e')),
        data: (List<Activity> activities) {
          if (activities.isEmpty) {
            return const Center(child: Text('Aucune activité pour le moment.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: activities.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final a = activities[index];
              final base = a.color;
              final bg = base.withValues(alpha: 0.12);

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ActivityDetailPage(activity: a),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: base.withValues(alpha: 0.35),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Text(a.emoji, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          a.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Contrôles (start / pause / stop)
                      ActivityControls(activityId: a.id),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
