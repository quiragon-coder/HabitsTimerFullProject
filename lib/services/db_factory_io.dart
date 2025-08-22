import 'database_service_contract.dart';
import 'isar_database_service.dart';

Future<DatabaseService> createDb() => IsarDatabaseService.create();
