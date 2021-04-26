import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

// We are using Moor in this application. Moor helps us streamline working with
// SQLite, and allows us to use write queries in Dart. This eliminates
// errors if we were to do all of the work managing SQL reading writing etc by
// ourselves and allows us to develop faster.

// This class is a representation of House table in the database.
class Houses extends Table {
  IntColumn get houseID => integer()();
  IntColumn get number => integer()();
  BoolColumn get visited => boolean()();

  // Need to override primary key method to declare custom primary keys.
  @override
  Set<Column> get primaryKey => {houseID, number};
}

LazyDatabase _openConnection() {
  // LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

// This annotation tells moor to prepare a database class that uses Houses table.
@UseMoor(tables: [Houses])
class HouseAppDatabase extends _$HouseAppDatabase {
  // We tell the database where to store the data with this constructor
  HouseAppDatabase() : super(_openConnection());

  // CRUD queries.
  Future<int> insertHouse(House house) => into(houses).insert(house);
  Future<int> deleteHouse(House house) => delete(houses).delete(house);
  Future<bool> updateHouse(House house) => update(houses).replace(house);
  Future<List<House>> getHouseById(int id) =>
      (select(houses)..where((tbl) => tbl.houseID.equals(id))).get();
  Future<List<House>> getAllHouses() => select(houses).get();
  // CRUD end

  // Get a list of house IDs present in the database.
  Future<List<int?>> getDistinctHouses() {
    final query = selectOnly(houses, distinct: true)
      ..addColumns([houses.houseID]);
    return query.map((row) => row.read(houses.houseID)).get();
  }

  // Gets all those houses which have their visited parameter equal to @visited.
  Future<List<House>> checkAllVisited(bool visited) =>
      (select(houses)..where((tbl) => tbl.visited.equals(visited))).get();

  // Helps us check if the houses belonging to a particular houseID all have
  // their visited attribute set to true.
  Future<bool> areAllHousesVisited(int houseID) async {
    List<House> houses = await getHouseById(houseID);

    for (House house in houses) if (!house.visited) return false;

    return true;
  }

  // Get the last house (by number attribute) of a particular house ID.
  Future<House?> getLastHouse(int houseID) => (select(houses)
  ..where((tbl) => tbl.houseID.equals(houseID))
    ..orderBy([
          (t) => OrderingTerm(expression: t.number, mode: OrderingMode.desc)
    ])
    ..limit(1))
      .getSingle();

  // You should bump this number whenever you change or add a table definition.
  @override
  int get schemaVersion => 1;
}
