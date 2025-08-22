import 'package:flutter/material.dart';
import '../features/activities/presentation/home_screen.dart';

class HabitsTimerApp extends StatelessWidget {
  const HabitsTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habits Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6759FF)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
