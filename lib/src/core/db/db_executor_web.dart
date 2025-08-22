import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor openConnection() {
  // Sauvegarde côté navigateur (IndexedDB)
  return WebDatabase('habits_timer_web');
}
