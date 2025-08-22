import 'package:flutter/material.dart';

@immutable
class Activity {
  final int id;
  final String name;
  final String emoji;
  final int colorHex;
  const Activity({
    required this.id,
    required this.name,
    required this.emoji,
    required this.colorHex,
  });

  Color get color => Color(colorHex);
}
