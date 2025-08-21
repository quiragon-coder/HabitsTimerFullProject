import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/database_service_contract.dart';
import '../services/stats_service.dart';

final statsProvider = Provider<StatsService>((ref) => StatsService(ref.read(dbProvider)));
