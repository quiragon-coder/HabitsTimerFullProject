import 'package:drift/drift.dart';

class Activities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get emoji => text().withLength(min: 1, max: 4)();
  IntColumn get colorHex => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // Goals (minutes for hours to keep integer)
  IntColumn get goalHoursPerWeek => integer().nullable()(); // minutes
  IntColumn get goalDaysPerWeek => integer().nullable()();  // 0..7
  IntColumn get goalHoursPerDay => integer().nullable()();  // minutes
}

class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get activityId => integer().references(Activities, #id)();
  DateTimeColumn get startTs => dateTime()();
  DateTimeColumn get endTs => dateTime().nullable()();
  TextColumn get note => text().nullable()();

  @override
  List<String> get customConstraints => ['CHECK (endTs IS NULL OR endTs >= startTs)'];

  @override
  List<Set<Column>> get uniqueKeys => [{activityId, startTs}];
}

class Pauses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(Sessions, #id)();
  DateTimeColumn get startTs => dateTime()();
  DateTimeColumn get endTs => dateTime()();

  @override
  List<String> get customConstraints => ['CHECK (endTs >= startTs)'];
}
