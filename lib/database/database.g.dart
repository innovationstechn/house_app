// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  HouseDAO? _houseProgressDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HouseModel` (`houseID` INTEGER NOT NULL, `number` INTEGER NOT NULL, `visited` INTEGER NOT NULL, PRIMARY KEY (`houseID`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  HouseDAO get houseProgressDAO {
    return _houseProgressDAOInstance ??= _$HouseDAO(database, changeListener);
  }
}

class _$HouseDAO extends HouseDAO {
  _$HouseDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _houseModelInsertionAdapter = InsertionAdapter(
            database,
            'HouseModel',
            (HouseModel item) => <String, Object?>{
                  'houseID': item.houseID,
                  'number': item.number,
                  'visited': item.visited ? 1 : 0
                }),
        _houseModelUpdateAdapter = UpdateAdapter(
            database,
            'HouseModel',
            ['houseID'],
            (HouseModel item) => <String, Object?>{
                  'houseID': item.houseID,
                  'number': item.number,
                  'visited': item.visited ? 1 : 0
                }),
        _houseModelDeletionAdapter = DeletionAdapter(
            database,
            'HouseModel',
            ['houseID'],
            (HouseModel item) => <String, Object?>{
                  'houseID': item.houseID,
                  'number': item.number,
                  'visited': item.visited ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HouseModel> _houseModelInsertionAdapter;

  final UpdateAdapter<HouseModel> _houseModelUpdateAdapter;

  final DeletionAdapter<HouseModel> _houseModelDeletionAdapter;

  @override
  Future<List<HouseModel>> getAllProgress() async {
    return _queryAdapter.queryList('SELECT * FROM Person',
        mapper: (Map<String, Object?> row) => HouseModel(
            houseID: row['houseID'] as int,
            number: row['number'] as int,
            visited: (row['visited'] as int) != 0));
  }

  @override
  Future<HouseModel?> getHouse(int houseID, int number) async {
    return _queryAdapter.query(
        'SELECT * FROM Person WHERE houseID = ?1 AND number = ?2',
        mapper: (Map<String, Object?> row) => HouseModel(
            houseID: row['houseID'] as int,
            number: row['number'] as int,
            visited: (row['visited'] as int) != 0),
        arguments: [houseID, number]);
  }

  @override
  Future<void> newProgress(HouseModel person) async {
    await _houseModelInsertionAdapter.insert(person, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProgress(HouseModel progress) async {
    await _houseModelUpdateAdapter.update(progress, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProgress(HouseModel progress) async {
    await _houseModelDeletionAdapter.delete(progress);
  }
}
