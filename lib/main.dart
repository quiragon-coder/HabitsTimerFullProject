import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers_timer.dart';
import 'pages/activities_list_page.dart';
import 'services/isar_database_service.dart';
import 'services/web_database_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = kIsWeb
      ? await WebDatabaseService.create()
      : await IsarDatabaseService.create();

  runApp(
    ProviderScope(
      overrides: [dbProvider.overrideWithValue(db)],
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
    );
  }
}
