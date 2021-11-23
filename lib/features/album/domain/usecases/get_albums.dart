import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/features/album/domain/repositories/album_repository.dart';
import 'package:clean_arch/features/album/domain/entities/album.dart'
    as entitie;
import 'package:dartz/dartz.dart';

class GetAlbums {
  final AlbumRepository repository;

  GetAlbums({required this.repository});

  Future<Either<Failure, List<entitie.Album>>?> call() async {
    return await repository.getAllAlbums();
  }
}
