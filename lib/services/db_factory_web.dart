import 'database_service_contract.dart';
import 'web_database_service.dart';

Future<DatabaseService> createDb() => WebDatabaseService.create();
