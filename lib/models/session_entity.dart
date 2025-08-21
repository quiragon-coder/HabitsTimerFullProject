import 'package:isar/isar.dart';

part 'session_entity.g.dart';

@collection
class SessionEntity {
  Id id = Isar.autoIncrement;
  late int activityId;
  late DateTime startedAt;
  DateTime? endedAt;
}
