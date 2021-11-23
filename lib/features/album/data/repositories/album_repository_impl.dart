import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/core/platform/network_info.dart';
import 'package:clean_arch/features/album/data/datasources/album_local_datasource.dart';
import 'package:clean_arch/features/album/data/datasources/album_remote_datasource.dart';
import 'package:clean_arch/features/album/data/models/album.dart';
import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/features/album/domain/repositories/album_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch/features/album/domain/entities/album.dart'
    as entitie;

class AlbunmRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource albumRemoteDataSource;
  final AlbumLocalDatasource albumLocalDataSource;
  final NetworkInfo networkInfo;

  AlbunmRepositoryImpl({
    required this.albumRemoteDataSource,
    required this.albumLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, entitie.Album>> getAlbum(int id) async {
    return Right(await albumRemoteDataSource.getAlbum(id));
  }

  @override
  Future<Either<Failure, List<entitie.Album>>?> getAllAlbums() async {
    if (await networkInfo.isConnected) {
      try {
        final List<AlbumModel> albums =
            await albumRemoteDataSource.getAllAlbums();
        albumLocalDataSource.cacheAlbums(albums);
        return Right(albums);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localAlbums = await albumLocalDataSource.getLastAlbums();
        return Right(localAlbums);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, entitie.Album>> createAlbum(
      entitie.Album album) async {
    final albumReceived =
        await albumRemoteDataSource.createAlbum(album as AlbumModel);
    return Right(albumReceived);
  }

  @override
  Future<Either<Failure, AlbumModel>> deleteAlbum(int id) async {
    return Right(await albumRemoteDataSource.deleteAlbum(id));
  }

  @override
  Future<Either<Failure, AlbumModel>> updateAlbum(entitie.Album album) async {
    return Right(await albumRemoteDataSource.updateAlbum(album as AlbumModel));
  }
}
