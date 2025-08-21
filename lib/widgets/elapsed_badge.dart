import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers_timer.dart';

class ElapsedBadge extends ConsumerWidget {
  const ElapsedBadge({super.key, required this.activityId});

  final int activityId;

  String _fmt(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:'
          '${m.toString().padLeft(2, '0')}:'
          '${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elapsed = ref.watch(runningElapsedProvider(activityId));

    return elapsed.when(
      data: (d) => Chip(label: Text(_fmt(d))),
      loading: () => const Chip(label: Text('--:--')),
      error: (_, __) => const Chip(label: Text('00:00')),
    );
  }
}
