import 'package:isar/isar.dart';

part 'session_entity.g.dart';

@collection
class SessionEntity {
  Id id = Isar.autoIncrement;

  @Index()
  late int activityId;

  @Index()
  late DateTime startedAt;

  DateTime? endedAt;
}
