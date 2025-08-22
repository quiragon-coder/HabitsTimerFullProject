import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../activities/application/providers.dart';
import '../../activities/domain/activity.dart';
import 'activity_detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activitiesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits Timer'),
      ),
      body: ListView.separated(
        itemCount: activities.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final a = activities[index];
          return _ActivityTile(activity: a);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Création d’activité — bientôt ✨')),
          );
        },
        label: const Text('Nouvelle activité'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final Activity activity;
  const _ActivityTile({required this.activity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: activity.color.withOpacity(.15),
        child: Text(activity.emoji, style: const TextStyle(fontSize: 20)),
      ),
      title: Text(activity.name),
      subtitle: const Text('Appuyez pour voir le timer et les stats'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ActivityDetailScreen(activity: activity)),
        );
      },
    );
  }
}
