import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/database_service.dart';
import 'services/stats_service.dart';

final dbProvider = Provider<DatabaseService>((ref) => DatabaseService());
final statsProvider = Provider<StatsService>((ref) => StatsService(ref.read(dbProvider)));
