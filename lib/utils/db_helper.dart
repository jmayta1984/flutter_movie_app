import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../models/movie.dart';

class DbHelper {
  final int version = 1;
  final String databaseName = 'movies.db';
  final String tableName = "movies";

  Database? db;

  Future<Database> openDb() async {
    db ??= await openDatabase(join(await getDatabasesPath(), databaseName),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, title TEXT, poster TEXT)');
      }, version: version);
    return db as Database;
  }

  insert(Movie movie) async {
    await db?.insert(tableName, movie.toMap());
  }

  delete(Movie movie) async {
    await db?.delete(tableName, where: 'id=?', whereArgs: [movie.id!]);
  }

  Future<bool> isFavorite(Movie movie) async{
    final maps = await db?.query(tableName, where: 'id=?', whereArgs: [movie.id!]);
    return maps!.isNotEmpty;
  }
}
