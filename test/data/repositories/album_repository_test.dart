import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_widget_integration_unit/data/datasources/album_remote_data_source.dart';
import 'package:flutter_test_widget_integration_unit/data/repositories/album_repository.dart';
import 'package:flutter_test_widget_integration_unit/error/exception/http_request_exception.dart';
import 'package:flutter_test_widget_integration_unit/error/failure/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../constants/test_constants.dart';
import 'album_repository_test.mocks.dart';

@GenerateMocks([AlbumRemoteDataSource])
void main() {
  late MockAlbumRemoteDataSource mockRemoteDataSource;
  late AlbumRepository albumRepository;

  setUp(() {
    mockRemoteDataSource = MockAlbumRemoteDataSource();
    albumRepository =
        AlbumRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('create', () {
    test(
        'should create a Album when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.create(any)).thenAnswer((_) async => Void);

      final response = await albumRepository.create(albumToCreate);

      expect(response, equals(const Right(unit)));
    });

    test(
        'should return a PostRequestFailure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.create(any))
          .thenThrow(HttpRequestException(httpError: httpError));

      final response = await albumRepository.create(albumToCreate);

      expect(
          response,
          equals(Left<Failure, Unit>(
              PostRequestFailure(message: httpError.toString()))));
    });
  });

  group('getAll', () {
    test(
        'should return a album list when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.fetchAll()).thenAnswer((_) async => tAlbumList);

      final response = await albumRepository.fetchAll();

      expect(response, equals(const Right(tAlbumList)));
    });

    test(
        'should return a GetRequestFailure when the call to remote source is unsuccessful',
        () async {
      when(mockRemoteDataSource.fetchAll())
          .thenThrow(HttpRequestException(httpError: httpError));

      final response = await albumRepository.fetchAll();

      expect(response,
          equals(Left(GetRequestFailure(message: httpError.toString()))));
    });
  });

  group("getById", () {
    test('should return a Album when the call to remote source is successful',
        () async {
      when(mockRemoteDataSource.fetchById(any)).thenAnswer((_) async => tAlbum);

      final response = await albumRepository.fetchById(tId);

      expect(response, equals(Right(tAlbum)));
    });

    test(
        'should return a GetRequestFailure when the call to remote source is unsuccessful',
        () async {
      when(mockRemoteDataSource.fetchById(any))
          .thenThrow(HttpRequestException(httpError: httpError));

      final response = await albumRepository.fetchById(tId);

      expect(response,
          equals(Left(GetRequestFailure(message: httpError.toString()))));
    });
  });
}
