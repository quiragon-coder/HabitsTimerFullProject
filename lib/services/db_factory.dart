import 'database_service_contract.dart';

// Choix du fichier en fonction de la plateforme :
// - Web  -> db_factory_web.dart
// - IO   -> db_factory_io.dart (Android/iOS/Windows/macOS/Linux)
import 'db_factory_io.dart' if (dart.library.html) 'db_factory_web.dart';

/// Retourne l'implémentation de DatabaseService adaptée à la plateforme.
Future<DatabaseService> createDatabaseService() => createDb();
