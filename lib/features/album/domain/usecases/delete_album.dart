import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/features/album/domain/repositories/album_repository.dart';
import 'package:clean_arch/features/album/domain/entities/album.dart'
    as entitie;
import 'package:dartz/dartz.dart';

class DeleteAlbum {
  final AlbumRepository? repository;

  DeleteAlbum({this.repository});

  Future<Either<Failure, entitie.Album>?> call(int id) async {
    return await repository!.deleteAlbum(id);
  }
}
