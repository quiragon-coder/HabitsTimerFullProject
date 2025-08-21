import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==> Ajout : notre service Isar prêt à l’emploi
import 'services/isar_database_service.dart';

// ==> Ajout : providers (dbProvider + elapsed/isRunning/isPaused)
import 'providers/providers_timer.dart';

// (Optionnel) si tu as déjà ta page d’accueil :
import 'pages/activities_list_page.dart'; // adapte l’import si besoin

Future<void> main() async {
  // Nécessaire pour pouvoir faire du async avant runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 1) On crée/ouvre la base Isar
  final isarDb = await IsarDatabaseService.create();

  // 2) On injecte l’implémentation concrète dans Riverpod
  runApp(
    ProviderScope(
      overrides: [
        dbProvider.overrideWithValue(isarDb),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habits Timer',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6C63FF),
      ),

      // Si tu as déjà ActivitiesListPage dans ton projet, garde-la en home :
      home: const ActivitiesListPage(),

      // Si tu veux activer les traductions (tu as déjà flutter_localizations dans pubspec) :
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en'),
      //   Locale('fr'),
      // ],
    );
  }
}
