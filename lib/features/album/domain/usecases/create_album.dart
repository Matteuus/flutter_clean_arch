import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/features/album/domain/repositories/album_repository.dart';
import 'package:clean_arch/features/album/domain/entities/album.dart'
    as entitie;
import 'package:dartz/dartz.dart';

class CreateAlbum {
  final AlbumRepository? repository;

  CreateAlbum({this.repository});

  Future<Either<Failure, entitie.Album>?> call(entitie.Album album) async {
    return await repository?.createAlbum(album);
  }
}
