import 'package:flutter_test_widget_integration_unit/data/models/album.dart';
import 'package:flutter_test_widget_integration_unit/data/repositories/album_repository.dart';
import 'package:mobx/mobx.dart';
part 'album_controller.g.dart';

class AlbumController = AlbumControllerBase with _$AlbumController;

abstract class AlbumControllerBase with Store {
  final AlbumRepository repository;

  AlbumControllerBase({required this.repository});

  @observable
  ObservableList<Album> albums = ObservableList<Album>.of([]);

  @observable
  String errorMessage = "";

  @observable
  Album? album;

  @action
  getAllAlbums() async {
    final albumsOrFailure = await repository.fetchAll();

    albumsOrFailure.fold((failure) => errorMessage = failure.message,
        (a) => albums = a.asObservable());
  }

  @action
  getAlbumById(int albumId) async {
    final albumOrFailure = await repository.fetchById(albumId);

    albumOrFailure.fold(
        (failure) => errorMessage = failure.message, (a) => album = a);
  }

  @action
  createAlbum(Album album) async {
    final createdAlbumOrFailure = await repository.create(album);

    createdAlbumOrFailure.fold(
        (failure) => errorMessage = failure.message, (r) => null);
  }
}
