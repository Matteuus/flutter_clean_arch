import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/features/album/domain/entities/album.dart';
import 'package:dartz/dartz.dart';

abstract class AlbumRepository {
  Future<Either<Failure, List<Album>>?> getAllAlbums();
  Future<Either<Failure, Album>?> getAlbum(int id);
  Future<Either<Failure, Album>?> updateAlbum(Album album);
  Future<Either<Failure, Album>?> deleteAlbum(int id);
  Future<Either<Failure, Album>?> createAlbum(Album album);
}
