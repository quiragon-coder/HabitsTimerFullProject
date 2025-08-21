import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/activity.dart';
import '../providers.dart';
import '../providers_timer.dart';
import 'activity_detail_page.dart';

class ActivitiesListPage extends ConsumerWidget {
  const ActivitiesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Habits Timer')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.of(context).pushNamed('/create');
          // Rien à faire ici : la liste vient d'un Stream.
          // Pas de db.notifyListeners(): DatabaseService n’est pas un ChangeNotifier.
          if (created == true) {
            // Optionnel : on peut simplement laisser le Stream rafraîchir l’écran.
          }
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Activity>>(
        stream: db.watchActivities(),
        builder: (context, snap) {
          final items = snap.data ?? const <Activity>[];
          if (items.isEmpty) {
            return const Center(child: Text('Aucune activité pour le moment'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final a = items[index];
              final elapsed = ref.watch(elapsedStreamProvider(a.id.toString()));
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: a.color.withValues(alpha: 0.15),
                  child: Text(a.emoji),
                ),
                title: Text(a.name),
                subtitle: elapsed.when(
                  data: (d) =>
                      Text("${d.inMinutes}m ${(d.inSeconds % 60).toString().padLeft(2, '0')}s"),
                  loading: () => const Text("…"),
                  error: (_, __) => const Text("—"),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ActivityDetailPage(activity: a)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
