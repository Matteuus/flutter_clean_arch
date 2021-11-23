import 'package:clean_arch/features/album/data/models/album.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseRepository {
  Future<List<AlbumModel>> getAll();
  insert(List<AlbumModel> rows);
  update(List<AlbumModel> rows);
  Future<AlbumModel> findById(id);
}

class DatabaseRepositoryImpl implements DatabaseRepository {
  static const _table = "album";
  Future<Database?> database;

  DatabaseRepositoryImpl({required this.database});

  @override
  Future<List<AlbumModel>> getAll() async {
    final Database? db = await database;

    try {
      final album = await db!.query(_table);

      return List.generate(album.length, (index) {
        return AlbumModel(
          id: int.parse(album[index]["id"].toString()),
          title: album[index]["title"].toString(),
          userId: int.parse(album[index]["userId"].toString()),
        );
      });
    } catch (error) {
      debugPrint(error.toString());
    }
    return [];
  }

  @override
  insert(List<AlbumModel> rows) async {
    final Database? db = await database;
    Batch batch = db!.batch();
    try {
      for (var row in rows) {
        batch.insert(_table, row.toJson());
      }
      await batch.commit(noResult: true);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  update(List<AlbumModel> rows) async {
    final Database? db = await database;
    Batch batch = db!.batch();
    try {
      for (var row in rows) {
        batch
            .update(_table, row.toJson(), where: "id = ?", whereArgs: [row.id]);
      }
      await batch.commit(noResult: true);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Future<AlbumModel> findById(id) async {
    final Database? db = await database;
    try {
      List<Map<String, dynamic>> maps = await db!.query(_table,
          columns: ["id", "userId", "title"], where: 'id = ?', whereArgs: [id]);

      if (maps.isNotEmpty) {
        return AlbumModel.fromJson(maps.first);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return const AlbumModel();
  }
}
