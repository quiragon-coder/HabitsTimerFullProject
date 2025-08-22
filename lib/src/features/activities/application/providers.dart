import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/activity.dart';

// Canonical provider names for coherence.
final activitiesProvider = StateProvider<List<Activity>>((ref) {
  return const [
    Activity(id: 1, name: 'Dessin', emoji: '🎨', colorHex: 0xFF6759FF),
    Activity(id: 2, name: 'Sport',  emoji: '🏃', colorHex: 0xFF00B894),
    Activity(id: 3, name: 'Lecture',emoji: '📚', colorHex: 0xFFFFC046),
  ];
});
