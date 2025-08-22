import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers_timer.dart';
import '../services/database_service_contract.dart';

class ActivityHistory extends ConsumerWidget {
  const ActivityHistory({super.key, required this.activityId});

  final int activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);

    return FutureBuilder<List<DbSession>>(
      future: db.listSessionsByActivity(activityId),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final sessions = snap.data ?? const <DbSession>[];
        if (sessions.isEmpty) {
          return const Center(child: Text('Aucune session'));
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sessions.length,
          separatorBuilder: (_, __) => const Divider(height: 16),
          itemBuilder: (context, i) {
            final s = sessions[i];
            return _SessionTile(session: s);
          },
        );
      },
    );
  }
}

class _SessionTile extends ConsumerWidget {
  const _SessionTile({required this.session});

  final DbSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);

    return FutureBuilder<List<DbPause>>(
      future: db.listPausesBySession(session.id),
      builder: (context, snap) {
        final pauses = snap.data ?? const <DbPause>[];
        final start = session.startedAt.toLocal();
        final end = (session.endedAt ?? DateTime.now().toUtc()).toLocal();

        // durée effective = (fin - début) - total pauses
        final totalPaused = pauses.fold<Duration>(
          Duration.zero,
              (acc, p) {
            final pStart = p.startAt.toLocal();
            final pEnd = (p.endAt ?? DateTime.now().toUtc()).toLocal();
            final overlap = _overlapBetween(pStart, pEnd, start, end);
            return acc + overlap;
          },
        );
        final effective = end.difference(start) - totalPaused;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${_fmtDate(start)}  •  ${_fmtTime(start)} → ${_fmtTime(end)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              "Durée effective: ${_fmtDuration(effective)}"
                  "${pauses.isNotEmpty ? "  (pauses: ${pauses.length})" : ""}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (pauses.isNotEmpty) ...[
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: pauses.map((p) {
                  final ps = p.startAt.toLocal();
                  final pe = (p.endAt ?? DateTime.now().toUtc()).toLocal();
                  return Chip(
                    label: Text("Pause ${_fmtTime(ps)}–${_fmtTime(pe)}"),
                  );
                }).toList(),
              )
            ],
          ],
        );
      },
    );
  }
}

String _fmtTime(DateTime t) =>
    "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
String _fmtDate(DateTime t) =>
    "${t.day.toString().padLeft(2, '0')}/${t.month.toString().padLeft(2, '0')}/${t.year}";
String _fmtDuration(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  final s = d.inSeconds.remainder(60);
  if (h > 0) return '${h}h ${m}m ${s}s';
  if (m > 0) return '${m}m ${s}s';
  return '${s}s';
}

Duration _overlapBetween(
    DateTime aStart,
    DateTime aEnd,
    DateTime bStart,
    DateTime bEnd,
    ) {
  final start = aStart.isAfter(bStart) ? aStart : bStart;
  final end = aEnd.isBefore(bEnd) ? aEnd : bEnd;
  if (end.isBefore(start)) return Duration.zero;
  return end.difference(start);
}
