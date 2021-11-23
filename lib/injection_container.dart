import 'package:clean_arch/core/database/init_database.dart';
import 'package:clean_arch/core/database/repository_database.dart';
import 'package:clean_arch/core/platform/network_info.dart';
import 'package:clean_arch/features/album/data/datasources/album_local_datasource.dart';
import 'package:clean_arch/features/album/data/datasources/album_remote_datasource.dart';
import 'package:clean_arch/features/album/data/repositories/album_repository_impl.dart';
import 'package:clean_arch/features/album/domain/repositories/album_repository.dart';
import 'package:clean_arch/features/album/domain/usecases/create_album.dart';
import 'package:clean_arch/features/album/domain/usecases/delete_album.dart';
import 'package:clean_arch/features/album/domain/usecases/get_album.dart';
import 'package:clean_arch/features/album/domain/usecases/get_albums.dart';
import 'package:clean_arch/features/album/domain/usecases/update_album.dart';
import 'package:clean_arch/features/album/presentation/mobx/album_store.dart';
import 'package:connectivity/connectivity.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => AlbumStore(
      receivedCreateAlbum: CreateAlbum(repository: sl()),
      receivedDeleteAlbum: DeleteAlbum(repository: sl()),
      receivedGetAlbum: GetAlbum(repository: sl()),
      receivedGetAlbums: GetAlbums(repository: sl()),
      receivedUpdateAlbum: UpdateAlbum(repository: sl()),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CreateAlbum(repository: sl()));
  sl.registerLazySingleton(() => DeleteAlbum(repository: sl()));
  sl.registerLazySingleton(() => GetAlbum(repository: sl()));
  sl.registerLazySingleton(() => GetAlbums(repository: sl()));
  sl.registerLazySingleton(() => UpdateAlbum(repository: sl()));

  // Repository
  sl.registerLazySingleton<AlbumRepository>(
    () => AlbunmRepositoryImpl(
      albumLocalDataSource: sl(),
      networkInfo: sl(),
      albumRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<DatabaseRepository>(
      () => DatabaseRepositoryImpl(database: DatabaseHelper.instance.database));

  // Data sources
  sl.registerLazySingleton<AlbumRemoteDataSource>(
      () => AlbumRemoteDataSouceImpl(dio: sl()));
  sl.registerLazySingleton<AlbumLocalDatasource>(
      () => AlbumLocalDatasourceImpl(databaseRepository: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
}
