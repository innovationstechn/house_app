//GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class House extends DataClass implements Insertable<House> {
  final int houseID;
  final int number;
  final bool visited;
  House({required this.houseID, required this.number, required this.visited});
  factory House.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return House(
      houseID:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}house_i_d'])!,
      number:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}number'])!,
      visited:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}visited'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['house_i_d'] = Variable<int>(houseID);
    map['number'] = Variable<int>(number);
    map['visited'] = Variable<bool>(visited);
    return map;
  }

  HousesCompanion toCompanion(bool nullToAbsent) {
    return HousesCompanion(
      houseID: Value(houseID),
      number: Value(number),
      visited: Value(visited),
    );
  }

  factory House.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return House(
      houseID: serializer.fromJson<int>(json['houseID']),
      number: serializer.fromJson<int>(json['number']),
      visited: serializer.fromJson<bool>(json['visited']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'houseID': serializer.toJson<int>(houseID),
      'number': serializer.toJson<int>(number),
      'visited': serializer.toJson<bool>(visited),
    };
  }

  House copyWith({int? houseID, int? number, bool? visited}) => House(
        houseID: houseID ?? this.houseID,
        number: number ?? this.number,
        visited: visited ?? this.visited,
      );
  @override
  String toString() {
    return (StringBuffer('House(')
          ..write('houseID: $houseID, ')
          ..write('number: $number, ')
          ..write('visited: $visited')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(houseID.hashCode, $mrjc(number.hashCode, visited.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is House &&
          other.houseID == this.houseID &&
          other.number == this.number &&
          other.visited == this.visited);
}

class HousesCompanion extends UpdateCompanion<House> {
  final Value<int> houseID;
  final Value<int> number;
  final Value<bool> visited;
  const HousesCompanion({
    this.houseID = const Value.absent(),
    this.number = const Value.absent(),
    this.visited = const Value.absent(),
  });
  HousesCompanion.insert({
    this.houseID = const Value.absent(),
    required int number,
    required bool visited,
  })   : number = Value(number),
        visited = Value(visited);
  static Insertable<House> custom({
    Expression<int>? houseID,
    Expression<int>? number,
    Expression<bool>? visited,
  }) {
    return RawValuesInsertable({
      if (houseID != null) 'house_i_d': houseID,
      if (number != null) 'number': number,
      if (visited != null) 'visited': visited,
    });
  }

  HousesCompanion copyWith(
      {Value<int>? houseID, Value<int>? number, Value<bool>? visited}) {
    return HousesCompanion(
      houseID: houseID ?? this.houseID,
      number: number ?? this.number,
      visited: visited ?? this.visited,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (houseID.present) {
      map['house_i_d'] = Variable<int>(houseID.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (visited.present) {
      map['visited'] = Variable<bool>(visited.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HousesCompanion(')
          ..write('houseID: $houseID, ')
          ..write('number: $number, ')
          ..write('visited: $visited')
          ..write(')'))
        .toString();
  }
}

class $HousesTable extends Houses with TableInfo<$HousesTable, House> {
  final GeneratedDatabase _db;
  final String? _alias;
  $HousesTable(this._db, [this._alias]);
  final VerificationMeta _houseIDMeta = const VerificationMeta('houseID');
  @override
  late final GeneratedIntColumn houseID = _constructHouseID();
  GeneratedIntColumn _constructHouseID() {
    return GeneratedIntColumn(
      'house_i_d',
      $tableName,
      false,
    );
  }

  final VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedIntColumn number = _constructNumber();
  GeneratedIntColumn _constructNumber() {
    return GeneratedIntColumn(
      'number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _visitedMeta = const VerificationMeta('visited');
  @override
  late final GeneratedBoolColumn visited = _constructVisited();
  GeneratedBoolColumn _constructVisited() {
    return GeneratedBoolColumn(
      'visited',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [houseID, number, visited];
  @override
  $HousesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'houses';
  @override
  final String actualTableName = 'houses';
  @override
  VerificationContext validateIntegrity(Insertable<House> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('house_i_d')) {
      context.handle(_houseIDMeta,
          houseID.isAcceptableOrUnknown(data['house_i_d']!, _houseIDMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('visited')) {
      context.handle(_visitedMeta,
          visited.isAcceptableOrUnknown(data['visited']!, _visitedMeta));
    } else if (isInserting) {
      context.missing(_visitedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {houseID};
  @override
  House map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return House.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $HousesTable createAlias(String alias) {
    return $HousesTable(_db, alias);
  }
}

abstract class _$HouseAppDatabase extends GeneratedDatabase {
  _$HouseAppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $HousesTable houses = $HousesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [houses];
}
