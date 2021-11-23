import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/features/album/domain/repositories/album_repository.dart';
import 'package:clean_arch/features/album/domain/entities/album.dart'
    as entitie;
import 'package:dartz/dartz.dart';

class UpdateAlbum {
  final AlbumRepository? repository;

  UpdateAlbum({this.repository});

  Future<Either<Failure, entitie.Album>?> call(entitie.Album album) async {
    return await repository!.updateAlbum(album);
  }
}
