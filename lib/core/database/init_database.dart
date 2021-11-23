import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  static _initDatabase() async {
    try {
      String path = join(
          await getDatabasesPath(), DatabaseHelperEnum.getValue(DATABASE.name));
      return await openDatabase(path,
          version: DatabaseHelperEnum.getValue(DATABASE.version),
          onCreate: _onCreate,
          onConfigure: _onConfigure);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
    debugPrint('Foreign keys turned on');
  }

  static _onCreate(Database db, int version) async {
    var sql = [
      '''DROP TABLE IF EXISTS album;''',
      '''create table if not exists album (
            id integer,
            title text,
            userId integer
            );''',
    ];

    for (var i = 0; i < sql.length; i++) {
      debugPrint("execute sql : " + sql[i]);
      await db.execute(sql[i]).catchError((error) {
        debugPrint(error.toString());
      });
    }
  }
}

enum DATABASE {
  name,
  version,
}

class DatabaseHelperEnum {
  static dynamic getValue(DATABASE databaseName) {
    switch (databaseName) {
      case DATABASE.name:
        return "todo_tdd.db";
      case DATABASE.version:
        return 1;
      default:
        return "";
    }
  }
}
