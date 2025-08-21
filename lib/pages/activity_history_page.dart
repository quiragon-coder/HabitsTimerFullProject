import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers_timer.dart';
import '../services/database_service_contract.dart';

class ActivityHistoryPage extends ConsumerStatefulWidget {
  const ActivityHistoryPage({super.key, required this.activityId, required this.activityName});
  final int activityId;
  final String activityName;

  @override
  ConsumerState<ActivityHistoryPage> createState() => _ActivityHistoryPageState();
}

class _ActivityHistoryPageState extends ConsumerState<ActivityHistoryPage> {
  int _range = 30; // jours

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Historique • ${widget.activityName}')),
      body: FutureBuilder<List<DbSession>>(
        future: db.listSessionsByActivity(widget.activityId),
        builder: (context, snap) {
          final sessions = (snap.data ?? const <DbSession>[]).toList()
            ..sort((a,b) => (b.startedAt).compareTo(a.startedAt));
          final now = DateTime.now();
          final from = now.subtract(Duration(days: _range));
          final filtered = sessions.where((s) => s.startedAt.isAfter(from)).toList();
          if (filtered.isEmpty) return const Center(child: Text('Aucune session dans la période.'));
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, i) {
              final s = filtered[i];
              return FutureBuilder<List<DbPause>>(
                future: db.listPausesBySession(s.id),
                builder: (context, psnap) {
                  final pauses = psnap.data ?? const <DbPause>[];
                  final eff = _effective(s, pauses);
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text('${_fmtDate(s.startedAt)} → ${_fmtDate(s.endedAt ?? now)}'),
                    subtitle: Text('Durée effective: ${_fmtDur(eff)} • Pauses: ${pauses.length}'),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(12,0,12,12),
        child: SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 1, label: Text('1j')),
            ButtonSegment(value: 7, label: Text('7j')),
            ButtonSegment(value: 30, label: Text('30j')),
            ButtonSegment(value: 90, label: Text('90j')),
          ],
          selected: <int>{_range},
          onSelectionChanged: (s) => setState(() => _range = s.first),
        ),
      ),
    );
  }

  Duration _effective(DbSession s, List<DbPause> pauses) {
    final end = s.endedAt ?? DateTime.now();
    final total = end.difference(s.startedAt);
    Duration paused = Duration.zero;
    for (final p in pauses) {
      final pe = p.endAt ?? end;
      if (pe.isAfter(p.startAt)) paused += pe.difference(p.startAt);
    }
    final eff = total - paused;
    return eff.isNegative ? Duration.zero : eff;
  }

  String _fmtDur(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) return '${h}h ${m}m ${s}s';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  String _fmtDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
  }
}
