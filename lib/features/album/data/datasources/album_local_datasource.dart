import 'package:clean_arch/core/database/repository_database.dart';
import 'package:clean_arch/features/album/data/models/album.dart';
import 'package:flutter/material.dart';

abstract class AlbumLocalDatasource {
  Future<List<AlbumModel>> getLastAlbums();
  Future<void> cacheAlbums(List<AlbumModel> albumsToCache);
}

class AlbumLocalDatasourceImpl implements AlbumLocalDatasource {
  final DatabaseRepository databaseRepository;

  AlbumLocalDatasourceImpl({required this.databaseRepository});

  @override
  Future<void> cacheAlbums(List<AlbumModel> albumsToCache) async {
    debugPrint("call cache");
    List<AlbumModel> albumsAdd = <AlbumModel>[];
    List<AlbumModel> albumsUpdate = <AlbumModel>[];

    for (AlbumModel album in albumsToCache) {
      if (album.id != null) {
        albumsAdd.add(album);
      } else {
        albumsUpdate.add(album);
      }
    }

    // albumsToCache.forEach((f) async {
    //   await databaseRepository!.findById(f.id).then((album) {
    //     if (album.id != f.id) {
    //       albumsUpdate.add(f);
    //     } else {
    //       albumsAdd.add(f);
    //     }
    //   });
    // });
    await databaseRepository.update(albumsUpdate);
    await databaseRepository.insert(albumsAdd);
  }

  @override
  Future<List<AlbumModel>> getLastAlbums() async {
    var albums = await databaseRepository.getAll();
    debugPrint(albums.length.toString());
    return albums;
  }
}
