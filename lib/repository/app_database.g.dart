// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  PokemonDAO? _pokemonDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `Pokemon` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `type` TEXT NOT NULL, `evolve` TEXT NOT NULL, `hp` INTEGER NOT NULL, `force` INTEGER NOT NULL, `def` INTEGER NOT NULL, `xp` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokemonDAO get pokemonDao {
    return _pokemonDaoInstance ??= _$PokemonDAO(database, changeListener);
  }
}

class _$PokemonDAO extends PokemonDAO {
  _$PokemonDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _pokemonInsertionAdapter = InsertionAdapter(
            database,
            'Pokemon',
            (Pokemon item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'type': item.type,
                  'evolve': item.evolve,
                  'hp': item.hp,
                  'force': item.force,
                  'def': item.def,
                  'xp': item.xp
                },
            changeListener),
        _pokemonDeletionAdapter = DeletionAdapter(
            database,
            'Pokemon',
            ['id'],
            (Pokemon item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'type': item.type,
                  'evolve': item.evolve,
                  'hp': item.hp,
                  'force': item.force,
                  'def': item.def,
                  'xp': item.xp
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Pokemon> _pokemonInsertionAdapter;

  final DeletionAdapter<Pokemon> _pokemonDeletionAdapter;

  @override
  Future<List<Pokemon>> findAllPokemon() async {
    return _queryAdapter.queryList('SELECT * FROM Pokemon',
        mapper: (Map<String, Object?> row) => Pokemon(
            row['id'] as int,
            row['name'] as String,
            row['type'] as String,
            row['evolve'] as String,
            row['hp'] as int,
            row['force'] as int,
            row['def'] as int,
            row['xp'] as int));
  }

  @override
  Stream<List<String>> findAll() {
    return _queryAdapter.queryListStream('SELECT name FROM Pokemon',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        queryableName: 'Pokemon',
        isView: false);
  }

  @override
  Stream<Pokemon?> findPokemonById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Pokemon WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Pokemon(
            row['id'] as int,
            row['name'] as String,
            row['type'] as String,
            row['evolve'] as String,
            row['hp'] as int,
            row['force'] as int,
            row['def'] as int,
            row['xp'] as int),
        arguments: [id],
        queryableName: 'Pokemon',
        isView: false);
  }

  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    await _pokemonInsertionAdapter.insert(pokemon, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePokemon(Pokemon pokemon) async {
    await _pokemonDeletionAdapter.delete(pokemon);
  }
}
