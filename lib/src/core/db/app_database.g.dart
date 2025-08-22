// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ActivitiesTable extends Activities
    with TableInfo<$ActivitiesTable, Activity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
      'emoji', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<int> colorHex = GeneratedColumn<int>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _goalHoursPerWeekMeta =
      const VerificationMeta('goalHoursPerWeek');
  @override
  late final GeneratedColumn<int> goalHoursPerWeek = GeneratedColumn<int>(
      'goal_hours_per_week', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _goalDaysPerWeekMeta =
      const VerificationMeta('goalDaysPerWeek');
  @override
  late final GeneratedColumn<int> goalDaysPerWeek = GeneratedColumn<int>(
      'goal_days_per_week', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _goalHoursPerDayMeta =
      const VerificationMeta('goalHoursPerDay');
  @override
  late final GeneratedColumn<int> goalHoursPerDay = GeneratedColumn<int>(
      'goal_hours_per_day', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        emoji,
        colorHex,
        createdAt,
        goalHoursPerWeek,
        goalDaysPerWeek,
        goalHoursPerDay
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activities';
  @override
  VerificationContext validateIntegrity(Insertable<Activity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
          _emojiMeta, emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta));
    } else if (isInserting) {
      context.missing(_emojiMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    } else if (isInserting) {
      context.missing(_colorHexMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('goal_hours_per_week')) {
      context.handle(
          _goalHoursPerWeekMeta,
          goalHoursPerWeek.isAcceptableOrUnknown(
              data['goal_hours_per_week']!, _goalHoursPerWeekMeta));
    }
    if (data.containsKey('goal_days_per_week')) {
      context.handle(
          _goalDaysPerWeekMeta,
          goalDaysPerWeek.isAcceptableOrUnknown(
              data['goal_days_per_week']!, _goalDaysPerWeekMeta));
    }
    if (data.containsKey('goal_hours_per_day')) {
      context.handle(
          _goalHoursPerDayMeta,
          goalHoursPerDay.isAcceptableOrUnknown(
              data['goal_hours_per_day']!, _goalHoursPerDayMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Activity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Activity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      emoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}emoji'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_hex'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      goalHoursPerWeek: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}goal_hours_per_week']),
      goalDaysPerWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_days_per_week']),
      goalHoursPerDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_hours_per_day']),
    );
  }

  @override
  $ActivitiesTable createAlias(String alias) {
    return $ActivitiesTable(attachedDatabase, alias);
  }
}

class Activity extends DataClass implements Insertable<Activity> {
  final int id;
  final String name;
  final String emoji;
  final int colorHex;
  final DateTime createdAt;
  final int? goalHoursPerWeek;
  final int? goalDaysPerWeek;
  final int? goalHoursPerDay;
  const Activity(
      {required this.id,
      required this.name,
      required this.emoji,
      required this.colorHex,
      required this.createdAt,
      this.goalHoursPerWeek,
      this.goalDaysPerWeek,
      this.goalHoursPerDay});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['emoji'] = Variable<String>(emoji);
    map['color_hex'] = Variable<int>(colorHex);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || goalHoursPerWeek != null) {
      map['goal_hours_per_week'] = Variable<int>(goalHoursPerWeek);
    }
    if (!nullToAbsent || goalDaysPerWeek != null) {
      map['goal_days_per_week'] = Variable<int>(goalDaysPerWeek);
    }
    if (!nullToAbsent || goalHoursPerDay != null) {
      map['goal_hours_per_day'] = Variable<int>(goalHoursPerDay);
    }
    return map;
  }

  ActivitiesCompanion toCompanion(bool nullToAbsent) {
    return ActivitiesCompanion(
      id: Value(id),
      name: Value(name),
      emoji: Value(emoji),
      colorHex: Value(colorHex),
      createdAt: Value(createdAt),
      goalHoursPerWeek: goalHoursPerWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(goalHoursPerWeek),
      goalDaysPerWeek: goalDaysPerWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(goalDaysPerWeek),
      goalHoursPerDay: goalHoursPerDay == null && nullToAbsent
          ? const Value.absent()
          : Value(goalHoursPerDay),
    );
  }

  factory Activity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Activity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      emoji: serializer.fromJson<String>(json['emoji']),
      colorHex: serializer.fromJson<int>(json['colorHex']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      goalHoursPerWeek: serializer.fromJson<int?>(json['goalHoursPerWeek']),
      goalDaysPerWeek: serializer.fromJson<int?>(json['goalDaysPerWeek']),
      goalHoursPerDay: serializer.fromJson<int?>(json['goalHoursPerDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'emoji': serializer.toJson<String>(emoji),
      'colorHex': serializer.toJson<int>(colorHex),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'goalHoursPerWeek': serializer.toJson<int?>(goalHoursPerWeek),
      'goalDaysPerWeek': serializer.toJson<int?>(goalDaysPerWeek),
      'goalHoursPerDay': serializer.toJson<int?>(goalHoursPerDay),
    };
  }

  Activity copyWith(
          {int? id,
          String? name,
          String? emoji,
          int? colorHex,
          DateTime? createdAt,
          Value<int?> goalHoursPerWeek = const Value.absent(),
          Value<int?> goalDaysPerWeek = const Value.absent(),
          Value<int?> goalHoursPerDay = const Value.absent()}) =>
      Activity(
        id: id ?? this.id,
        name: name ?? this.name,
        emoji: emoji ?? this.emoji,
        colorHex: colorHex ?? this.colorHex,
        createdAt: createdAt ?? this.createdAt,
        goalHoursPerWeek: goalHoursPerWeek.present
            ? goalHoursPerWeek.value
            : this.goalHoursPerWeek,
        goalDaysPerWeek: goalDaysPerWeek.present
            ? goalDaysPerWeek.value
            : this.goalDaysPerWeek,
        goalHoursPerDay: goalHoursPerDay.present
            ? goalHoursPerDay.value
            : this.goalHoursPerDay,
      );
  Activity copyWithCompanion(ActivitiesCompanion data) {
    return Activity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      goalHoursPerWeek: data.goalHoursPerWeek.present
          ? data.goalHoursPerWeek.value
          : this.goalHoursPerWeek,
      goalDaysPerWeek: data.goalDaysPerWeek.present
          ? data.goalDaysPerWeek.value
          : this.goalDaysPerWeek,
      goalHoursPerDay: data.goalHoursPerDay.present
          ? data.goalHoursPerDay.value
          : this.goalHoursPerDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Activity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji, ')
          ..write('colorHex: $colorHex, ')
          ..write('createdAt: $createdAt, ')
          ..write('goalHoursPerWeek: $goalHoursPerWeek, ')
          ..write('goalDaysPerWeek: $goalDaysPerWeek, ')
          ..write('goalHoursPerDay: $goalHoursPerDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, emoji, colorHex, createdAt,
      goalHoursPerWeek, goalDaysPerWeek, goalHoursPerDay);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Activity &&
          other.id == this.id &&
          other.name == this.name &&
          other.emoji == this.emoji &&
          other.colorHex == this.colorHex &&
          other.createdAt == this.createdAt &&
          other.goalHoursPerWeek == this.goalHoursPerWeek &&
          other.goalDaysPerWeek == this.goalDaysPerWeek &&
          other.goalHoursPerDay == this.goalHoursPerDay);
}

class ActivitiesCompanion extends UpdateCompanion<Activity> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> emoji;
  final Value<int> colorHex;
  final Value<DateTime> createdAt;
  final Value<int?> goalHoursPerWeek;
  final Value<int?> goalDaysPerWeek;
  final Value<int?> goalHoursPerDay;
  const ActivitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.emoji = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.goalHoursPerWeek = const Value.absent(),
    this.goalDaysPerWeek = const Value.absent(),
    this.goalHoursPerDay = const Value.absent(),
  });
  ActivitiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String emoji,
    required int colorHex,
    this.createdAt = const Value.absent(),
    this.goalHoursPerWeek = const Value.absent(),
    this.goalDaysPerWeek = const Value.absent(),
    this.goalHoursPerDay = const Value.absent(),
  })  : name = Value(name),
        emoji = Value(emoji),
        colorHex = Value(colorHex);
  static Insertable<Activity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? emoji,
    Expression<int>? colorHex,
    Expression<DateTime>? createdAt,
    Expression<int>? goalHoursPerWeek,
    Expression<int>? goalDaysPerWeek,
    Expression<int>? goalHoursPerDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (emoji != null) 'emoji': emoji,
      if (colorHex != null) 'color_hex': colorHex,
      if (createdAt != null) 'created_at': createdAt,
      if (goalHoursPerWeek != null) 'goal_hours_per_week': goalHoursPerWeek,
      if (goalDaysPerWeek != null) 'goal_days_per_week': goalDaysPerWeek,
      if (goalHoursPerDay != null) 'goal_hours_per_day': goalHoursPerDay,
    });
  }

  ActivitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? emoji,
      Value<int>? colorHex,
      Value<DateTime>? createdAt,
      Value<int?>? goalHoursPerWeek,
      Value<int?>? goalDaysPerWeek,
      Value<int?>? goalHoursPerDay}) {
    return ActivitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      colorHex: colorHex ?? this.colorHex,
      createdAt: createdAt ?? this.createdAt,
      goalHoursPerWeek: goalHoursPerWeek ?? this.goalHoursPerWeek,
      goalDaysPerWeek: goalDaysPerWeek ?? this.goalDaysPerWeek,
      goalHoursPerDay: goalHoursPerDay ?? this.goalHoursPerDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<int>(colorHex.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (goalHoursPerWeek.present) {
      map['goal_hours_per_week'] = Variable<int>(goalHoursPerWeek.value);
    }
    if (goalDaysPerWeek.present) {
      map['goal_days_per_week'] = Variable<int>(goalDaysPerWeek.value);
    }
    if (goalHoursPerDay.present) {
      map['goal_hours_per_day'] = Variable<int>(goalHoursPerDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji, ')
          ..write('colorHex: $colorHex, ')
          ..write('createdAt: $createdAt, ')
          ..write('goalHoursPerWeek: $goalHoursPerWeek, ')
          ..write('goalDaysPerWeek: $goalDaysPerWeek, ')
          ..write('goalHoursPerDay: $goalHoursPerDay')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _activityIdMeta =
      const VerificationMeta('activityId');
  @override
  late final GeneratedColumn<int> activityId = GeneratedColumn<int>(
      'activity_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES activities (id)'));
  static const VerificationMeta _startTsMeta =
      const VerificationMeta('startTs');
  @override
  late final GeneratedColumn<DateTime> startTs = GeneratedColumn<DateTime>(
      'start_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTsMeta = const VerificationMeta('endTs');
  @override
  late final GeneratedColumn<DateTime> endTs = GeneratedColumn<DateTime>(
      'end_ts', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, activityId, startTs, endTs, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<Session> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('activity_id')) {
      context.handle(
          _activityIdMeta,
          activityId.isAcceptableOrUnknown(
              data['activity_id']!, _activityIdMeta));
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('start_ts')) {
      context.handle(_startTsMeta,
          startTs.isAcceptableOrUnknown(data['start_ts']!, _startTsMeta));
    } else if (isInserting) {
      context.missing(_startTsMeta);
    }
    if (data.containsKey('end_ts')) {
      context.handle(
          _endTsMeta, endTs.isAcceptableOrUnknown(data['end_ts']!, _endTsMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {activityId, startTs},
      ];
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      activityId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}activity_id'])!,
      startTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_ts'])!,
      endTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_ts']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final int id;
  final int activityId;
  final DateTime startTs;
  final DateTime? endTs;
  final String? note;
  const Session(
      {required this.id,
      required this.activityId,
      required this.startTs,
      this.endTs,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['activity_id'] = Variable<int>(activityId);
    map['start_ts'] = Variable<DateTime>(startTs);
    if (!nullToAbsent || endTs != null) {
      map['end_ts'] = Variable<DateTime>(endTs);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      activityId: Value(activityId),
      startTs: Value(startTs),
      endTs:
          endTs == null && nullToAbsent ? const Value.absent() : Value(endTs),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Session.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<int>(json['id']),
      activityId: serializer.fromJson<int>(json['activityId']),
      startTs: serializer.fromJson<DateTime>(json['startTs']),
      endTs: serializer.fromJson<DateTime?>(json['endTs']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'activityId': serializer.toJson<int>(activityId),
      'startTs': serializer.toJson<DateTime>(startTs),
      'endTs': serializer.toJson<DateTime?>(endTs),
      'note': serializer.toJson<String?>(note),
    };
  }

  Session copyWith(
          {int? id,
          int? activityId,
          DateTime? startTs,
          Value<DateTime?> endTs = const Value.absent(),
          Value<String?> note = const Value.absent()}) =>
      Session(
        id: id ?? this.id,
        activityId: activityId ?? this.activityId,
        startTs: startTs ?? this.startTs,
        endTs: endTs.present ? endTs.value : this.endTs,
        note: note.present ? note.value : this.note,
      );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      activityId:
          data.activityId.present ? data.activityId.value : this.activityId,
      startTs: data.startTs.present ? data.startTs.value : this.startTs,
      endTs: data.endTs.present ? data.endTs.value : this.endTs,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('activityId: $activityId, ')
          ..write('startTs: $startTs, ')
          ..write('endTs: $endTs, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, activityId, startTs, endTs, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.activityId == this.activityId &&
          other.startTs == this.startTs &&
          other.endTs == this.endTs &&
          other.note == this.note);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<int> id;
  final Value<int> activityId;
  final Value<DateTime> startTs;
  final Value<DateTime?> endTs;
  final Value<String?> note;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.activityId = const Value.absent(),
    this.startTs = const Value.absent(),
    this.endTs = const Value.absent(),
    this.note = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required int activityId,
    required DateTime startTs,
    this.endTs = const Value.absent(),
    this.note = const Value.absent(),
  })  : activityId = Value(activityId),
        startTs = Value(startTs);
  static Insertable<Session> custom({
    Expression<int>? id,
    Expression<int>? activityId,
    Expression<DateTime>? startTs,
    Expression<DateTime>? endTs,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activityId != null) 'activity_id': activityId,
      if (startTs != null) 'start_ts': startTs,
      if (endTs != null) 'end_ts': endTs,
      if (note != null) 'note': note,
    });
  }

  SessionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? activityId,
      Value<DateTime>? startTs,
      Value<DateTime?>? endTs,
      Value<String?>? note}) {
    return SessionsCompanion(
      id: id ?? this.id,
      activityId: activityId ?? this.activityId,
      startTs: startTs ?? this.startTs,
      endTs: endTs ?? this.endTs,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<int>(activityId.value);
    }
    if (startTs.present) {
      map['start_ts'] = Variable<DateTime>(startTs.value);
    }
    if (endTs.present) {
      map['end_ts'] = Variable<DateTime>(endTs.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('activityId: $activityId, ')
          ..write('startTs: $startTs, ')
          ..write('endTs: $endTs, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $PausesTable extends Pauses with TableInfo<$PausesTable, Pause> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PausesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
      'session_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sessions (id)'));
  static const VerificationMeta _startTsMeta =
      const VerificationMeta('startTs');
  @override
  late final GeneratedColumn<DateTime> startTs = GeneratedColumn<DateTime>(
      'start_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTsMeta = const VerificationMeta('endTs');
  @override
  late final GeneratedColumn<DateTime> endTs = GeneratedColumn<DateTime>(
      'end_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, sessionId, startTs, endTs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pauses';
  @override
  VerificationContext validateIntegrity(Insertable<Pause> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('start_ts')) {
      context.handle(_startTsMeta,
          startTs.isAcceptableOrUnknown(data['start_ts']!, _startTsMeta));
    } else if (isInserting) {
      context.missing(_startTsMeta);
    }
    if (data.containsKey('end_ts')) {
      context.handle(
          _endTsMeta, endTs.isAcceptableOrUnknown(data['end_ts']!, _endTsMeta));
    } else if (isInserting) {
      context.missing(_endTsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pause map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pause(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_id'])!,
      startTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_ts'])!,
      endTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_ts'])!,
    );
  }

  @override
  $PausesTable createAlias(String alias) {
    return $PausesTable(attachedDatabase, alias);
  }
}

class Pause extends DataClass implements Insertable<Pause> {
  final int id;
  final int sessionId;
  final DateTime startTs;
  final DateTime endTs;
  const Pause(
      {required this.id,
      required this.sessionId,
      required this.startTs,
      required this.endTs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['start_ts'] = Variable<DateTime>(startTs);
    map['end_ts'] = Variable<DateTime>(endTs);
    return map;
  }

  PausesCompanion toCompanion(bool nullToAbsent) {
    return PausesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      startTs: Value(startTs),
      endTs: Value(endTs),
    );
  }

  factory Pause.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pause(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      startTs: serializer.fromJson<DateTime>(json['startTs']),
      endTs: serializer.fromJson<DateTime>(json['endTs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'startTs': serializer.toJson<DateTime>(startTs),
      'endTs': serializer.toJson<DateTime>(endTs),
    };
  }

  Pause copyWith(
          {int? id, int? sessionId, DateTime? startTs, DateTime? endTs}) =>
      Pause(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        startTs: startTs ?? this.startTs,
        endTs: endTs ?? this.endTs,
      );
  Pause copyWithCompanion(PausesCompanion data) {
    return Pause(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      startTs: data.startTs.present ? data.startTs.value : this.startTs,
      endTs: data.endTs.present ? data.endTs.value : this.endTs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pause(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('startTs: $startTs, ')
          ..write('endTs: $endTs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, startTs, endTs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pause &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.startTs == this.startTs &&
          other.endTs == this.endTs);
}

class PausesCompanion extends UpdateCompanion<Pause> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<DateTime> startTs;
  final Value<DateTime> endTs;
  const PausesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.startTs = const Value.absent(),
    this.endTs = const Value.absent(),
  });
  PausesCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required DateTime startTs,
    required DateTime endTs,
  })  : sessionId = Value(sessionId),
        startTs = Value(startTs),
        endTs = Value(endTs);
  static Insertable<Pause> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<DateTime>? startTs,
    Expression<DateTime>? endTs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (startTs != null) 'start_ts': startTs,
      if (endTs != null) 'end_ts': endTs,
    });
  }

  PausesCompanion copyWith(
      {Value<int>? id,
      Value<int>? sessionId,
      Value<DateTime>? startTs,
      Value<DateTime>? endTs}) {
    return PausesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      startTs: startTs ?? this.startTs,
      endTs: endTs ?? this.endTs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (startTs.present) {
      map['start_ts'] = Variable<DateTime>(startTs.value);
    }
    if (endTs.present) {
      map['end_ts'] = Variable<DateTime>(endTs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PausesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('startTs: $startTs, ')
          ..write('endTs: $endTs')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ActivitiesTable activities = $ActivitiesTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $PausesTable pauses = $PausesTable(this);
  late final ActivitiesDao activitiesDao = ActivitiesDao(this as AppDatabase);
  late final SessionsDao sessionsDao = SessionsDao(this as AppDatabase);
  late final PausesDao pausesDao = PausesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [activities, sessions, pauses];
}

typedef $$ActivitiesTableCreateCompanionBuilder = ActivitiesCompanion Function({
  Value<int> id,
  required String name,
  required String emoji,
  required int colorHex,
  Value<DateTime> createdAt,
  Value<int?> goalHoursPerWeek,
  Value<int?> goalDaysPerWeek,
  Value<int?> goalHoursPerDay,
});
typedef $$ActivitiesTableUpdateCompanionBuilder = ActivitiesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> emoji,
  Value<int> colorHex,
  Value<DateTime> createdAt,
  Value<int?> goalHoursPerWeek,
  Value<int?> goalDaysPerWeek,
  Value<int?> goalHoursPerDay,
});

final class $$ActivitiesTableReferences
    extends BaseReferences<_$AppDatabase, $ActivitiesTable, Activity> {
  $$ActivitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SessionsTable, List<Session>> _sessionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sessions,
          aliasName:
              $_aliasNameGenerator(db.activities.id, db.sessions.activityId));

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager($_db, $_db.sessions)
        .filter((f) => f.activityId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goalHoursPerWeek => $composableBuilder(
      column: $table.goalHoursPerWeek,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goalDaysPerWeek => $composableBuilder(
      column: $table.goalDaysPerWeek,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goalHoursPerDay => $composableBuilder(
      column: $table.goalHoursPerDay,
      builder: (column) => ColumnFilters(column));

  Expression<bool> sessionsRefs(
      Expression<bool> Function($$SessionsTableFilterComposer f) f) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.activityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableFilterComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalHoursPerWeek => $composableBuilder(
      column: $table.goalHoursPerWeek,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalDaysPerWeek => $composableBuilder(
      column: $table.goalDaysPerWeek,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalHoursPerDay => $composableBuilder(
      column: $table.goalHoursPerDay,
      builder: (column) => ColumnOrderings(column));
}

class $$ActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<int> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get goalHoursPerWeek => $composableBuilder(
      column: $table.goalHoursPerWeek, builder: (column) => column);

  GeneratedColumn<int> get goalDaysPerWeek => $composableBuilder(
      column: $table.goalDaysPerWeek, builder: (column) => column);

  GeneratedColumn<int> get goalHoursPerDay => $composableBuilder(
      column: $table.goalHoursPerDay, builder: (column) => column);

  Expression<T> sessionsRefs<T extends Object>(
      Expression<T> Function($$SessionsTableAnnotationComposer a) f) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.activityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ActivitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ActivitiesTable,
    Activity,
    $$ActivitiesTableFilterComposer,
    $$ActivitiesTableOrderingComposer,
    $$ActivitiesTableAnnotationComposer,
    $$ActivitiesTableCreateCompanionBuilder,
    $$ActivitiesTableUpdateCompanionBuilder,
    (Activity, $$ActivitiesTableReferences),
    Activity,
    PrefetchHooks Function({bool sessionsRefs})> {
  $$ActivitiesTableTableManager(_$AppDatabase db, $ActivitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> emoji = const Value.absent(),
            Value<int> colorHex = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int?> goalHoursPerWeek = const Value.absent(),
            Value<int?> goalDaysPerWeek = const Value.absent(),
            Value<int?> goalHoursPerDay = const Value.absent(),
          }) =>
              ActivitiesCompanion(
            id: id,
            name: name,
            emoji: emoji,
            colorHex: colorHex,
            createdAt: createdAt,
            goalHoursPerWeek: goalHoursPerWeek,
            goalDaysPerWeek: goalDaysPerWeek,
            goalHoursPerDay: goalHoursPerDay,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String emoji,
            required int colorHex,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int?> goalHoursPerWeek = const Value.absent(),
            Value<int?> goalDaysPerWeek = const Value.absent(),
            Value<int?> goalHoursPerDay = const Value.absent(),
          }) =>
              ActivitiesCompanion.insert(
            id: id,
            name: name,
            emoji: emoji,
            colorHex: colorHex,
            createdAt: createdAt,
            goalHoursPerWeek: goalHoursPerWeek,
            goalDaysPerWeek: goalDaysPerWeek,
            goalHoursPerDay: goalHoursPerDay,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ActivitiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (sessionsRefs) db.sessions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sessionsRefs)
                    await $_getPrefetchedData<Activity, $ActivitiesTable,
                            Session>(
                        currentTable: table,
                        referencedTable:
                            $$ActivitiesTableReferences._sessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ActivitiesTableReferences(db, table, p0)
                                .sessionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.activityId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ActivitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ActivitiesTable,
    Activity,
    $$ActivitiesTableFilterComposer,
    $$ActivitiesTableOrderingComposer,
    $$ActivitiesTableAnnotationComposer,
    $$ActivitiesTableCreateCompanionBuilder,
    $$ActivitiesTableUpdateCompanionBuilder,
    (Activity, $$ActivitiesTableReferences),
    Activity,
    PrefetchHooks Function({bool sessionsRefs})>;
typedef $$SessionsTableCreateCompanionBuilder = SessionsCompanion Function({
  Value<int> id,
  required int activityId,
  required DateTime startTs,
  Value<DateTime?> endTs,
  Value<String?> note,
});
typedef $$SessionsTableUpdateCompanionBuilder = SessionsCompanion Function({
  Value<int> id,
  Value<int> activityId,
  Value<DateTime> startTs,
  Value<DateTime?> endTs,
  Value<String?> note,
});

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ActivitiesTable _activityIdTable(_$AppDatabase db) =>
      db.activities.createAlias(
          $_aliasNameGenerator(db.sessions.activityId, db.activities.id));

  $$ActivitiesTableProcessedTableManager get activityId {
    final $_column = $_itemColumn<int>('activity_id')!;

    final manager = $$ActivitiesTableTableManager($_db, $_db.activities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PausesTable, List<Pause>> _pausesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.pauses,
          aliasName: $_aliasNameGenerator(db.sessions.id, db.pauses.sessionId));

  $$PausesTableProcessedTableManager get pausesRefs {
    final manager = $$PausesTableTableManager($_db, $_db.pauses)
        .filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pausesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTs => $composableBuilder(
      column: $table.startTs, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTs => $composableBuilder(
      column: $table.endTs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$ActivitiesTableFilterComposer get activityId {
    final $$ActivitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activityId,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableFilterComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> pausesRefs(
      Expression<bool> Function($$PausesTableFilterComposer f) f) {
    final $$PausesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pauses,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PausesTableFilterComposer(
              $db: $db,
              $table: $db.pauses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTs => $composableBuilder(
      column: $table.startTs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTs => $composableBuilder(
      column: $table.endTs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$ActivitiesTableOrderingComposer get activityId {
    final $$ActivitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activityId,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableOrderingComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTs =>
      $composableBuilder(column: $table.startTs, builder: (column) => column);

  GeneratedColumn<DateTime> get endTs =>
      $composableBuilder(column: $table.endTs, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$ActivitiesTableAnnotationComposer get activityId {
    final $$ActivitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activityId,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> pausesRefs<T extends Object>(
      Expression<T> Function($$PausesTableAnnotationComposer a) f) {
    final $$PausesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pauses,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PausesTableAnnotationComposer(
              $db: $db,
              $table: $db.pauses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SessionsTable,
    Session,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableAnnotationComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder,
    (Session, $$SessionsTableReferences),
    Session,
    PrefetchHooks Function({bool activityId, bool pausesRefs})> {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> activityId = const Value.absent(),
            Value<DateTime> startTs = const Value.absent(),
            Value<DateTime?> endTs = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              SessionsCompanion(
            id: id,
            activityId: activityId,
            startTs: startTs,
            endTs: endTs,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int activityId,
            required DateTime startTs,
            Value<DateTime?> endTs = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              SessionsCompanion.insert(
            id: id,
            activityId: activityId,
            startTs: startTs,
            endTs: endTs,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SessionsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({activityId = false, pausesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pausesRefs) db.pauses],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (activityId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.activityId,
                    referencedTable:
                        $$SessionsTableReferences._activityIdTable(db),
                    referencedColumn:
                        $$SessionsTableReferences._activityIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pausesRefs)
                    await $_getPrefetchedData<Session, $SessionsTable, Pause>(
                        currentTable: table,
                        referencedTable:
                            $$SessionsTableReferences._pausesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SessionsTableReferences(db, table, p0).pausesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SessionsTable,
    Session,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableAnnotationComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder,
    (Session, $$SessionsTableReferences),
    Session,
    PrefetchHooks Function({bool activityId, bool pausesRefs})>;
typedef $$PausesTableCreateCompanionBuilder = PausesCompanion Function({
  Value<int> id,
  required int sessionId,
  required DateTime startTs,
  required DateTime endTs,
});
typedef $$PausesTableUpdateCompanionBuilder = PausesCompanion Function({
  Value<int> id,
  Value<int> sessionId,
  Value<DateTime> startTs,
  Value<DateTime> endTs,
});

final class $$PausesTableReferences
    extends BaseReferences<_$AppDatabase, $PausesTable, Pause> {
  $$PausesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) => db.sessions
      .createAlias($_aliasNameGenerator(db.pauses.sessionId, db.sessions.id));

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$SessionsTableTableManager($_db, $_db.sessions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PausesTableFilterComposer
    extends Composer<_$AppDatabase, $PausesTable> {
  $$PausesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTs => $composableBuilder(
      column: $table.startTs, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTs => $composableBuilder(
      column: $table.endTs, builder: (column) => ColumnFilters(column));

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableFilterComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PausesTableOrderingComposer
    extends Composer<_$AppDatabase, $PausesTable> {
  $$PausesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTs => $composableBuilder(
      column: $table.startTs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTs => $composableBuilder(
      column: $table.endTs, builder: (column) => ColumnOrderings(column));

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableOrderingComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PausesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PausesTable> {
  $$PausesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTs =>
      $composableBuilder(column: $table.startTs, builder: (column) => column);

  GeneratedColumn<DateTime> get endTs =>
      $composableBuilder(column: $table.endTs, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PausesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PausesTable,
    Pause,
    $$PausesTableFilterComposer,
    $$PausesTableOrderingComposer,
    $$PausesTableAnnotationComposer,
    $$PausesTableCreateCompanionBuilder,
    $$PausesTableUpdateCompanionBuilder,
    (Pause, $$PausesTableReferences),
    Pause,
    PrefetchHooks Function({bool sessionId})> {
  $$PausesTableTableManager(_$AppDatabase db, $PausesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PausesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PausesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PausesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sessionId = const Value.absent(),
            Value<DateTime> startTs = const Value.absent(),
            Value<DateTime> endTs = const Value.absent(),
          }) =>
              PausesCompanion(
            id: id,
            sessionId: sessionId,
            startTs: startTs,
            endTs: endTs,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sessionId,
            required DateTime startTs,
            required DateTime endTs,
          }) =>
              PausesCompanion.insert(
            id: id,
            sessionId: sessionId,
            startTs: startTs,
            endTs: endTs,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PausesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sessionId,
                    referencedTable:
                        $$PausesTableReferences._sessionIdTable(db),
                    referencedColumn:
                        $$PausesTableReferences._sessionIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PausesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PausesTable,
    Pause,
    $$PausesTableFilterComposer,
    $$PausesTableOrderingComposer,
    $$PausesTableAnnotationComposer,
    $$PausesTableCreateCompanionBuilder,
    $$PausesTableUpdateCompanionBuilder,
    (Pause, $$PausesTableReferences),
    Pause,
    PrefetchHooks Function({bool sessionId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db, _db.activities);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$PausesTableTableManager get pauses =>
      $$PausesTableTableManager(_db, _db.pauses);
}
