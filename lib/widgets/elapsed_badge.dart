import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers_timer.dart';

class ElapsedBadge extends ConsumerWidget {
  const ElapsedBadge({super.key, required this.activityId});
  final int activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elapsed = ref.watch(elapsedStreamProvider(activityId.toString()));

    return elapsed.when(
      data: (d) => Chip(
        label: Text("${d.inMinutes}m ${(d.inSeconds % 60).toString().padLeft(2, '0')}s"),
      ),
      loading: () => const Chip(label: Text('…')),
      error: (_, __) => const Chip(label: Text('—')),
    );
  }
}
