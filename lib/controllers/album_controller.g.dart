// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AlbumController on AlbumControllerBase, Store {
  late final _$albumsAtom =
      Atom(name: 'AlbumControllerBase.albums', context: context);

  @override
  ObservableList<Album> get albums {
    _$albumsAtom.reportRead();
    return super.albums;
  }

  @override
  set albums(ObservableList<Album> value) {
    _$albumsAtom.reportWrite(value, super.albums, () {
      super.albums = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'AlbumControllerBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$albumAtom =
      Atom(name: 'AlbumControllerBase.album', context: context);

  @override
  Album? get album {
    _$albumAtom.reportRead();
    return super.album;
  }

  @override
  set album(Album? value) {
    _$albumAtom.reportWrite(value, super.album, () {
      super.album = value;
    });
  }

  late final _$getAllAlbumsAsyncAction =
      AsyncAction('AlbumControllerBase.getAllAlbums', context: context);

  @override
  Future getAllAlbums() {
    return _$getAllAlbumsAsyncAction.run(() => super.getAllAlbums());
  }

  late final _$getAlbumByIdAsyncAction =
      AsyncAction('AlbumControllerBase.getAlbumById', context: context);

  @override
  Future getAlbumById(int albumId) {
    return _$getAlbumByIdAsyncAction.run(() => super.getAlbumById(albumId));
  }

  late final _$createAlbumAsyncAction =
      AsyncAction('AlbumControllerBase.createAlbum', context: context);

  @override
  Future createAlbum(Album album) {
    return _$createAlbumAsyncAction.run(() => super.createAlbum(album));
  }

  @override
  String toString() {
    return '''
albums: ${albums},
errorMessage: ${errorMessage},
album: ${album}
    ''';
  }
}
