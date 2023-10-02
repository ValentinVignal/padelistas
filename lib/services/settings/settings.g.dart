// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetSimpleSettingCollection on Isar {
  IsarCollection<String, SimpleSetting> get simpleSettings => this.collection();
}

const SimpleSettingSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'SimpleSetting',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'value',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, SimpleSetting>(
    serialize: serializeSimpleSetting,
    deserialize: deserializeSimpleSetting,
    deserializeProperty: deserializeSimpleSettingProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeSimpleSetting(IsarWriter writer, SimpleSetting object) {
  IsarCore.writeString(writer, 1, object.id);
  {
    final value = object.value;
    if (value == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      IsarCore.writeString(writer, 2, value);
    }
  }
  return Isar.fastHash(object.id);
}

@isarProtected
SimpleSetting deserializeSimpleSetting(IsarReader reader) {
  final String _id;
  _id = IsarCore.readString(reader, 1) ?? '';
  final String? _value;
  _value = IsarCore.readString(reader, 2);
  final object = SimpleSetting(
    id: _id,
    value: _value,
  );
  return object;
}

@isarProtected
dynamic deserializeSimpleSettingProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _SimpleSettingUpdate {
  bool call({
    required String id,
    String? value,
  });
}

class _SimpleSettingUpdateImpl implements _SimpleSettingUpdate {
  const _SimpleSettingUpdateImpl(this.collection);

  final IsarCollection<String, SimpleSetting> collection;

  @override
  bool call({
    required String id,
    Object? value = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (value != ignore) 2: value as String?,
        }) >
        0;
  }
}

sealed class _SimpleSettingUpdateAll {
  int call({
    required List<String> id,
    String? value,
  });
}

class _SimpleSettingUpdateAllImpl implements _SimpleSettingUpdateAll {
  const _SimpleSettingUpdateAllImpl(this.collection);

  final IsarCollection<String, SimpleSetting> collection;

  @override
  int call({
    required List<String> id,
    Object? value = ignore,
  }) {
    return collection.updateProperties(id, {
      if (value != ignore) 2: value as String?,
    });
  }
}

extension SimpleSettingUpdate on IsarCollection<String, SimpleSetting> {
  _SimpleSettingUpdate get update => _SimpleSettingUpdateImpl(this);

  _SimpleSettingUpdateAll get updateAll => _SimpleSettingUpdateAllImpl(this);
}

sealed class _SimpleSettingQueryUpdate {
  int call({
    String? value,
  });
}

class _SimpleSettingQueryUpdateImpl implements _SimpleSettingQueryUpdate {
  const _SimpleSettingQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<SimpleSetting> query;
  final int? limit;

  @override
  int call({
    Object? value = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (value != ignore) 2: value as String?,
    });
  }
}

extension SimpleSettingQueryUpdate on IsarQuery<SimpleSetting> {
  _SimpleSettingQueryUpdate get updateFirst =>
      _SimpleSettingQueryUpdateImpl(this, limit: 1);

  _SimpleSettingQueryUpdate get updateAll =>
      _SimpleSettingQueryUpdateImpl(this);
}

class _SimpleSettingQueryBuilderUpdateImpl
    implements _SimpleSettingQueryUpdate {
  const _SimpleSettingQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<SimpleSetting, SimpleSetting, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? value = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (value != ignore) 2: value as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension SimpleSettingQueryBuilderUpdate
    on QueryBuilder<SimpleSetting, SimpleSetting, QOperations> {
  _SimpleSettingQueryUpdate get updateFirst =>
      _SimpleSettingQueryBuilderUpdateImpl(this, limit: 1);

  _SimpleSettingQueryUpdate get updateAll =>
      _SimpleSettingQueryBuilderUpdateImpl(this);
}

extension SimpleSettingQueryFilter
    on QueryBuilder<SimpleSetting, SimpleSetting, QFilterCondition> {
  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      idLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterFilterCondition>
      valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }
}

extension SimpleSettingQueryObject
    on QueryBuilder<SimpleSetting, SimpleSetting, QFilterCondition> {}

extension SimpleSettingQuerySortBy
    on QueryBuilder<SimpleSetting, SimpleSetting, QSortBy> {
  QueryBuilder<SimpleSetting, SimpleSetting, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterSortBy> sortByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterSortBy> sortByValue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterSortBy> sortByValueDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension SimpleSettingQuerySortThenBy
    on QueryBuilder<SimpleSetting, SimpleSetting, QSortThenBy> {
  QueryBuilder<SimpleSetting, SimpleSetting, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterSortBy> thenByValue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleSetting, SimpleSetting, QAfterSortBy> thenByValueDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension SimpleSettingQueryWhereDistinct
    on QueryBuilder<SimpleSetting, SimpleSetting, QDistinct> {
  QueryBuilder<SimpleSetting, SimpleSetting, QAfterDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }
}

extension SimpleSettingQueryProperty1
    on QueryBuilder<SimpleSetting, SimpleSetting, QProperty> {
  QueryBuilder<SimpleSetting, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SimpleSetting, String?, QAfterProperty> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension SimpleSettingQueryProperty2<R>
    on QueryBuilder<SimpleSetting, R, QAfterProperty> {
  QueryBuilder<SimpleSetting, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SimpleSetting, (R, String?), QAfterProperty> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension SimpleSettingQueryProperty3<R1, R2>
    on QueryBuilder<SimpleSetting, (R1, R2), QAfterProperty> {
  QueryBuilder<SimpleSetting, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SimpleSetting, (R1, R2, String?), QOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}
