import 'package:flutter/material.dart';

class ActivityStatsPanel extends StatelessWidget {
  const ActivityStatsPanel({super.key, required this.activityUid});
  final String activityUid;

  @override
  Widget build(BuildContext context) {
    // Placeholder simple et sûr (pas d’accès DB ici).
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: const [
        Chip(label: Text("Aujourd'hui: 0m")),
        Chip(label: Text("Cette semaine: 0m")),
        Chip(label: Text("Ce mois: 0m")),
        Chip(label: Text("Cette année: 0m")),
      ],
    );
  }
}
