import 'package:clean_arch/features/album/domain/usecases/create_album.dart';
import 'package:clean_arch/features/album/domain/usecases/delete_album.dart';
import 'package:clean_arch/features/album/domain/usecases/get_album.dart';
import 'package:clean_arch/features/album/domain/usecases/get_albums.dart';
import 'package:clean_arch/features/album/domain/usecases/update_album.dart';
import 'package:clean_arch/features/album/presentation/mobx/album_state.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'album_store.g.dart';

class AlbumStore = _AlbumStoreBase with _$AlbumStore;

abstract class _AlbumStoreBase with Store {
  @observable
  GetAlbums getAlbumsUseCase;

  @observable
  GetAlbum? getAlbumUseCase;

  @observable
  UpdateAlbum? updateAlbumUseCase;

  @observable
  DeleteAlbum? deleteAlbumUseCase;

  @observable
  CreateAlbum? createAlbumUseCase;

  _AlbumStoreBase(
      {required GetAlbums receivedGetAlbums,
      GetAlbum? receivedGetAlbum,
      UpdateAlbum? receivedUpdateAlbum,
      DeleteAlbum? receivedDeleteAlbum,
      CreateAlbum? receivedCreateAlbum})
      : getAlbumsUseCase = receivedGetAlbums,
        getAlbumUseCase = receivedGetAlbum,
        updateAlbumUseCase = receivedUpdateAlbum,
        deleteAlbumUseCase = receivedDeleteAlbum,
        createAlbumUseCase = receivedCreateAlbum;

  // @computed
  // AlbumState get initialState => const LoadingState();

  // @action
  // Future<AlbumState> mapEventToState(AlbumEvent event) async {
  //   const LoadingState();
  //   if (event is LoadingSucessAlbumEvent) {
  //     return _mapAlbumsLoadedToState();
  //   }
  // }

  @action
  Future<AlbumState> getAlbums() async {
    try {
      final result = await getAlbumsUseCase();
      return result!.fold((l) => const ErrorState("Erro ao carregar albums"),
          (r) => LoadedSucessState(r));
    } catch (e) {
      debugPrint(e.toString());
      return const ErrorState("Erro ao carregar albums");
    }
  }

  // @action
  // Future<AlbumState> _mapAlbumsLoadedToState() async {
  //   try {
  //     var albums = await getAlbums!();

  //     return albums!.fold((l) => const ErrorState("Error ao carregar albums"),
  //         (r) => LoadedSucessState(r));
  //   } catch (_) {
  //     return const ErrorState("Error ao carregar albums");
  //   }
  // }

  // @action
  // Future<AlbumState> _mapAlbumsAddedToState(CreateAlbumEvent event) async {
  //   try {
  //     if(state is LoadedSucessState) {
  //       var newAlbum = (await createAlbum!(event.album));

  //       return newAlbum!.fold((l) => const ErrorState("Error ao carregar albums"), (r) => LoadedSucessState(List<Album>.from(((state as LoadedSucessState).).toList()..add(r))));
  //     }
  //   } catch (_) {
  //     return const ErrorState("Error ao carregar albums");
  //   }
  // }
}
