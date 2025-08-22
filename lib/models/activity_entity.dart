import 'package:isar/isar.dart';
part 'activity_entity.g.dart';

@collection
class ActivityEntity {
  Id id = Isar.autoIncrement;

  late String name;
  late String emoji;
  late int colorValue;

  // objectifs en minutes (optionnels)
  int dailyGoalMinutes = 0;
  int weeklyGoalMinutes = 0;
  int monthlyGoalMinutes = 0;
  int yearlyGoalMinutes = 0;
}
