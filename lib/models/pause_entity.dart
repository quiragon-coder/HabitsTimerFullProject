import 'package:isar/isar.dart';

part 'pause_entity.g.dart';

@collection
class PauseEntity {
  Id id = Isar.autoIncrement;

  @Index()
  late int sessionId;

  @Index()
  late DateTime startAt;

  DateTime? endAt;
}
