import 'package:isar/isar.dart';

part 'pause_entity.g.dart';

@collection
class PauseEntity {
  Id id = Isar.autoIncrement;
  late int sessionId;
  late DateTime startAt;
  DateTime? endAt;
}
