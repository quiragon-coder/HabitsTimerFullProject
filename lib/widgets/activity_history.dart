import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityHistory extends ConsumerWidget {
  const ActivityHistory({
    super.key,
    required this.activityId,
  });

  final dynamic activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Historique',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Text('Aucune session terminée'),
      ],
    );
  }
}
