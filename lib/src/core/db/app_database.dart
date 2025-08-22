import 'package:drift/drift.dart';
import 'tables.dart';
import 'daos.dart';
import 'db_executor.dart'
  if (dart.library.io) 'db_executor_native.dart'
  if (dart.library.html) 'db_executor_web.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Activities, Sessions, Pauses],
  daos: [ActivitiesDao, SessionsDao, PausesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;
}
