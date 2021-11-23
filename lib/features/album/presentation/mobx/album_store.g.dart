// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlbumStore on _AlbumStoreBase, Store {
  final _$getAlbumsUseCaseAtom = Atom(name: '_AlbumStoreBase.getAlbumsUseCase');

  @override
  GetAlbums get getAlbumsUseCase {
    _$getAlbumsUseCaseAtom.reportRead();
    return super.getAlbumsUseCase;
  }

  @override
  set getAlbumsUseCase(GetAlbums value) {
    _$getAlbumsUseCaseAtom.reportWrite(value, super.getAlbumsUseCase, () {
      super.getAlbumsUseCase = value;
    });
  }

  final _$getAlbumUseCaseAtom = Atom(name: '_AlbumStoreBase.getAlbumUseCase');

  @override
  GetAlbum? get getAlbumUseCase {
    _$getAlbumUseCaseAtom.reportRead();
    return super.getAlbumUseCase;
  }

  @override
  set getAlbumUseCase(GetAlbum? value) {
    _$getAlbumUseCaseAtom.reportWrite(value, super.getAlbumUseCase, () {
      super.getAlbumUseCase = value;
    });
  }

  final _$updateAlbumUseCaseAtom =
      Atom(name: '_AlbumStoreBase.updateAlbumUseCase');

  @override
  UpdateAlbum? get updateAlbumUseCase {
    _$updateAlbumUseCaseAtom.reportRead();
    return super.updateAlbumUseCase;
  }

  @override
  set updateAlbumUseCase(UpdateAlbum? value) {
    _$updateAlbumUseCaseAtom.reportWrite(value, super.updateAlbumUseCase, () {
      super.updateAlbumUseCase = value;
    });
  }

  final _$deleteAlbumUseCaseAtom =
      Atom(name: '_AlbumStoreBase.deleteAlbumUseCase');

  @override
  DeleteAlbum? get deleteAlbumUseCase {
    _$deleteAlbumUseCaseAtom.reportRead();
    return super.deleteAlbumUseCase;
  }

  @override
  set deleteAlbumUseCase(DeleteAlbum? value) {
    _$deleteAlbumUseCaseAtom.reportWrite(value, super.deleteAlbumUseCase, () {
      super.deleteAlbumUseCase = value;
    });
  }

  final _$createAlbumUseCaseAtom =
      Atom(name: '_AlbumStoreBase.createAlbumUseCase');

  @override
  CreateAlbum? get createAlbumUseCase {
    _$createAlbumUseCaseAtom.reportRead();
    return super.createAlbumUseCase;
  }

  @override
  set createAlbumUseCase(CreateAlbum? value) {
    _$createAlbumUseCaseAtom.reportWrite(value, super.createAlbumUseCase, () {
      super.createAlbumUseCase = value;
    });
  }

  final _$getAlbumsAsyncAction = AsyncAction('_AlbumStoreBase.getAlbums');

  @override
  Future<AlbumState> getAlbums() {
    return _$getAlbumsAsyncAction.run(() => super.getAlbums());
  }

  @override
  String toString() {
    return '''
getAlbumsUseCase: ${getAlbumsUseCase},
getAlbumUseCase: ${getAlbumUseCase},
updateAlbumUseCase: ${updateAlbumUseCase},
deleteAlbumUseCase: ${deleteAlbumUseCase},
createAlbumUseCase: ${createAlbumUseCase}
    ''';
  }
}
