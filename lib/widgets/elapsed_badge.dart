import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_timer/providers_timer.dart';

class ElapsedBadge extends ConsumerWidget {
  final String activityId;
  const ElapsedBadge({super.key, required this.activityId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncElapsed = ref.watch(runningElapsedProvider(activityId));

    return asyncElapsed.when(
      data: (d) => _chip(_format(d)),
      loading: () => _chip('—'),
      error: (_, __) => _chip('—'),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blue.withOpacity(.12),
        border: Border.all(color: Colors.blue.withOpacity(.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer, size: 16),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  String _format(Duration d) {
    final s = d.inSeconds % 60;
    final m = d.inMinutes % 60;
    final h = d.inHours;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:'
          '${m.toString().padLeft(2, '0')}:'
          '${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }
}
