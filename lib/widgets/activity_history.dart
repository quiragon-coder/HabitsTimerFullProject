// lib/widgets/activity_history.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../models/session.dart';
import '../models/pause.dart';

class ActivityHistory extends ConsumerWidget {
  const ActivityHistory({super.key, required this.activityId});
  final int activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);

    return FutureBuilder<List<Session>>(
      future: db.listSessionsByActivity(activityId.toString()),
      builder: (context, snap) {
        final sessions = snap.data ?? const <Session>[];
        if (sessions.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text('Aucune session')),
          );
        }
        return Column(
          children: [for (final s in sessions) _SessionTile(session: s)],
        );
      },
    );
  }
}

class _SessionTile extends ConsumerWidget {
  const _SessionTile({required this.session});
  final Session session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);
    return FutureBuilder<List<Pause>>(
      future: db.listPausesBySession(session.id.toString()),
      builder: (context, snap) {
        final pauses = snap.data ?? const <Pause>[];
        final end = session.endedAt ?? DateTime.now();
        final duration = end.difference(session.startedAt);

        return ListTile(
          leading: const Icon(Icons.play_arrow),
          title:
          Text("${session.startedAt} → ${session.endedAt ?? 'en cours'}"),
          subtitle:
          Text("Durée: ${duration.inMinutes}m, Pauses: ${pauses.length}"),
        );
      },
    );
  }
}
