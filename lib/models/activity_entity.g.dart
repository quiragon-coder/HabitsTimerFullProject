// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetActivityEntityCollection on Isar {
  IsarCollection<ActivityEntity> get activityEntitys => this.collection();
}

const ActivityEntitySchema = CollectionSchema(
  name: r'ActivityEntity',
  id: 2979934318015624436,
  properties: {
    r'colorValue': PropertySchema(
      id: 0,
      name: r'colorValue',
      type: IsarType.long,
    ),
    r'dailyGoalMinutes': PropertySchema(
      id: 1,
      name: r'dailyGoalMinutes',
      type: IsarType.long,
    ),
    r'emoji': PropertySchema(
      id: 2,
      name: r'emoji',
      type: IsarType.string,
    ),
    r'monthlyGoalMinutes': PropertySchema(
      id: 3,
      name: r'monthlyGoalMinutes',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'weeklyGoalMinutes': PropertySchema(
      id: 5,
      name: r'weeklyGoalMinutes',
      type: IsarType.long,
    ),
    r'yearlyGoalMinutes': PropertySchema(
      id: 6,
      name: r'yearlyGoalMinutes',
      type: IsarType.long,
    )
  },
  estimateSize: _activityEntityEstimateSize,
  serialize: _activityEntitySerialize,
  deserialize: _activityEntityDeserialize,
  deserializeProp: _activityEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _activityEntityGetId,
  getLinks: _activityEntityGetLinks,
  attach: _activityEntityAttach,
  version: '3.1.0+1',
);

int _activityEntityEstimateSize(
  ActivityEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.emoji.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _activityEntitySerialize(
  ActivityEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.colorValue);
  writer.writeLong(offsets[1], object.dailyGoalMinutes);
  writer.writeString(offsets[2], object.emoji);
  writer.writeLong(offsets[3], object.monthlyGoalMinutes);
  writer.writeString(offsets[4], object.name);
  writer.writeLong(offsets[5], object.weeklyGoalMinutes);
  writer.writeLong(offsets[6], object.yearlyGoalMinutes);
}

ActivityEntity _activityEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ActivityEntity();
  object.colorValue = reader.readLong(offsets[0]);
  object.dailyGoalMinutes = reader.readLong(offsets[1]);
  object.emoji = reader.readString(offsets[2]);
  object.id = id;
  object.monthlyGoalMinutes = reader.readLong(offsets[3]);
  object.name = reader.readString(offsets[4]);
  object.weeklyGoalMinutes = reader.readLong(offsets[5]);
  object.yearlyGoalMinutes = reader.readLong(offsets[6]);
  return object;
}

P _activityEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _activityEntityGetId(ActivityEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _activityEntityGetLinks(ActivityEntity object) {
  return [];
}

void _activityEntityAttach(
    IsarCollection<dynamic> col, Id id, ActivityEntity object) {
  object.id = id;
}

extension ActivityEntityQueryWhereSort
    on QueryBuilder<ActivityEntity, ActivityEntity, QWhere> {
  QueryBuilder<ActivityEntity, ActivityEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ActivityEntityQueryWhere
    on QueryBuilder<ActivityEntity, ActivityEntity, QWhereClause> {
  QueryBuilder<ActivityEntity, ActivityEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActivityEntityQueryFilter
    on QueryBuilder<ActivityEntity, ActivityEntity, QFilterCondition> {
  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      colorValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      colorValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      colorValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      colorValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      dailyGoalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      dailyGoalMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      dailyGoalMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      dailyGoalMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailyGoalMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      emojiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      emojiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      emojiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      emojiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emoji',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      emojiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      emojiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      emojiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      emojiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emoji',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      emojiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emoji',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      emojiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emoji',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      monthlyGoalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthlyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      monthlyGoalMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monthlyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      monthlyGoalMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monthlyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      monthlyGoalMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monthlyGoalMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      weeklyGoalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weeklyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      weeklyGoalMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weeklyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      weeklyGoalMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weeklyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      weeklyGoalMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weeklyGoalMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      yearlyGoalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yearlyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      yearlyGoalMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yearlyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      yearlyGoalMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yearlyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterFilterCondition>
      yearlyGoalMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yearlyGoalMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActivityEntityQueryObject
    on QueryBuilder<ActivityEntity, ActivityEntity, QFilterCondition> {}

extension ActivityEntityQueryLinks
    on QueryBuilder<ActivityEntity, ActivityEntity, QFilterCondition> {}

extension ActivityEntityQuerySortBy
    on QueryBuilder<ActivityEntity, ActivityEntity, QSortBy> {
  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      sortByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      sortByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      sortByDailyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      sortByDailyGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy> sortByEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy> sortByEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      sortByMonthlyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      sortByMonthlyGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      sortByWeeklyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      sortByWeeklyGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      sortByYearlyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearlyGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      sortByYearlyGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearlyGoalMinutes', Sort.desc);
    });
  }
}

extension ActivityEntityQuerySortThenBy
    on QueryBuilder<ActivityEntity, ActivityEntity, QSortThenBy> {
  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      thenByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      thenByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      thenByDailyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      thenByDailyGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy> thenByEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy> thenByEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      thenByMonthlyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      thenByMonthlyGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      thenByWeeklyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      thenByWeeklyGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      thenByYearlyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearlyGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QAfterSortBy>
      thenByYearlyGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearlyGoalMinutes', Sort.desc);
    });
  }
}

extension ActivityEntityQueryWhereDistinct
    on QueryBuilder<ActivityEntity, ActivityEntity, QDistinct> {
  QueryBuilder<ActivityEntity, ActivityEntity, QDistinct>
      distinctByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorValue');
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QDistinct>
      distinctByDailyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyGoalMinutes');
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QDistinct> distinctByEmoji(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emoji', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QDistinct>
      distinctByMonthlyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthlyGoalMinutes');
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QDistinct>
      distinctByWeeklyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weeklyGoalMinutes');
    });
  }

  QueryBuilder<ActivityEntity, ActivityEntity, QDistinct>
      distinctByYearlyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'yearlyGoalMinutes');
    });
  }
}

extension ActivityEntityQueryProperty
    on QueryBuilder<ActivityEntity, ActivityEntity, QQueryProperty> {
  QueryBuilder<ActivityEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ActivityEntity, int, QQueryOperations> colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorValue');
    });
  }

  QueryBuilder<ActivityEntity, int, QQueryOperations>
      dailyGoalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyGoalMinutes');
    });
  }

  QueryBuilder<ActivityEntity, String, QQueryOperations> emojiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emoji');
    });
  }

  QueryBuilder<ActivityEntity, int, QQueryOperations>
      monthlyGoalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthlyGoalMinutes');
    });
  }

  QueryBuilder<ActivityEntity, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ActivityEntity, int, QQueryOperations>
      weeklyGoalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weeklyGoalMinutes');
    });
  }

  QueryBuilder<ActivityEntity, int, QQueryOperations>
      yearlyGoalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yearlyGoalMinutes');
    });
  }
}
