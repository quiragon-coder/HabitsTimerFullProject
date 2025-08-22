import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/stats_service.dart';
import 'providers_timer.dart';

final statsProvider = Provider<StatsService>((ref) {
  final db = ref.read(dbProvider);
  return StatsService(db);
});
