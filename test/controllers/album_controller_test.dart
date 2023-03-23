import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_widget_integration_unit/controllers/album_controller.dart';
import 'package:flutter_test_widget_integration_unit/data/repositories/album_repository.dart';
import 'package:flutter_test_widget_integration_unit/error/failure/failure.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../constants/test_constants.dart';
import 'album_controller_test.mocks.dart';

@GenerateMocks([AlbumRepository])
void main() {
  late MockAlbumRepository mockAlbumRepository;
  late AlbumController albumController;

  setUp(() {
    mockAlbumRepository = MockAlbumRepository();
    albumController = AlbumController(repository: mockAlbumRepository);
  });

  group("createAlbum", () {
    test('should create a album sucessfully', () async {
      when(mockAlbumRepository.create(any))
          .thenAnswer((_) async => const Right(unit));

      await albumController.createAlbum(albumToCreate);

      verify(mockAlbumRepository.create(albumToCreate));
    });

    test('''should change the [errorMessage] value 
        when a [PostRequestFailure] is returned from repository''', () async {
      when(mockAlbumRepository.create(any)).thenAnswer(
          (_) async => Left(PostRequestFailure(message: httpError.toString())));

      expect(albumController.errorMessage, equals(""));

      await albumController.createAlbum(albumToCreate);

      expect(albumController.errorMessage, equals(httpError.toString()));
    });
  });

  group('getAll', () {
    test('''should change the [albums] value 
          when a Album List is returned from repository''', () async {
      when(mockAlbumRepository.fetchAll())
          .thenAnswer((_) async => const Right(tAlbumList));

      expect(albumController.albums, equals([]));

      await albumController.getAllAlbums();

      expect(albumController.albums, equals(tAlbumList));
    });

    test('''should change the [errorMessage] value 
        when a [GetRequestFailure] is returned from repository''', () async {
      when(mockAlbumRepository.fetchAll()).thenAnswer(
          (_) async => Left(GetRequestFailure(message: httpError.toString())));

      expect(albumController.errorMessage, equals(""));

      await albumController.getAllAlbums();

      expect(albumController.errorMessage, equals(httpError.toString()));
    });
  });

  group('getById', () {
    test('''should change the [album] value 
          when a Albumis returned from repository''', () async {
      when(mockAlbumRepository.fetchById(any))
          .thenAnswer((_) async => Right(tAlbum));

      expect(albumController.album, equals(null));

      await albumController.getAlbumById(tId);

      expect(albumController.album, equals(tAlbum));
    });

    test('''should change the [errorMessage] value 
        when a [GetRequestFailure] is returned from repository''', () async {
      when(mockAlbumRepository.fetchById(any)).thenAnswer(
          (_) async => Left(GetRequestFailure(message: httpError.toString())));

      expect(albumController.errorMessage, equals(""));

      await albumController.getAlbumById(tId);

      expect(albumController.errorMessage, equals(httpError.toString()));
    });
  });
}
