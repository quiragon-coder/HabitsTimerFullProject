import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/isar_database_service.dart';
import 'providers_timer.dart';
import 'pages/activities_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isarDb = await IsarDatabaseService.create();

  runApp(
    ProviderScope(
      overrides: [dbProvider.overrideWithValue(isarDb)],
      child: const HabitsApp(),
    ),
  );
}

class HabitsApp extends StatelessWidget {
  const HabitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habits Timer',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6C63FF),
      ),
      home: const ActivitiesListPage(),
      // (décommente si tu veux les locales)
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [ Locale('en'), Locale('fr') ],
    );
  }
}
