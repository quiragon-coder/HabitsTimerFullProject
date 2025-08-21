import 'package:flutter/material.dart';

class Activity {
  final String id;
  String name;
  String emoji;
  final int colorValue;

  Activity({
    required this.id,
    required this.name,
    required this.emoji,
    required this.colorValue,
  });

  Color get color => Color(colorValue);
}
