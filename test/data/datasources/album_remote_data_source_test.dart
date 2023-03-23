import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_widget_integration_unit/data/datasources/album_remote_data_source.dart';
import 'package:flutter_test_widget_integration_unit/error/exception/http_request_exception.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../constants/test_constants.dart';
import '../../fixtures/fixture_read.dart';
import 'album_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late AlbumRemoteDataSourceImpl albumRemoteDataSourceImpl;

  setUp(() {
    mockClient = MockClient();
    albumRemoteDataSourceImpl = AlbumRemoteDataSourceImpl(client: mockClient);
  });

  void setUpMockGetRequestSuccess200(String filename) {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(fixture(filename), 200));
  }

  void setUpMockGetRequestFailure400() {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(errorMessage, 400));
  }

  group('getAll', () {
    test('should perform a GET request of all Albums', () async {
      setUpMockGetRequestSuccess200("album_list.json");

      await albumRemoteDataSourceImpl.fetchAll();

      verify(mockClient
          .get(Uri.parse("https://jsonplaceholder.typicode.com/albums")));
    });

    test('should return a Album list when the response code is 200', () async {
      setUpMockGetRequestSuccess200("album_list.json");

      final response = await albumRemoteDataSourceImpl.fetchAll();

      expect(response, equals(tAlbums));
    });

    test(
        'should throw a HttpOperationException when response code is greater than equal 400 ',
        () async {
      setUpMockGetRequestFailure400();

      final call = albumRemoteDataSourceImpl.fetchAll;

      expect(() => call(), throwsA(const TypeMatcher<HttpRequestException>()));
    });
  });

  group('getById', () {
    test('should perform a GET request on URL with [id] being the endpoint',
        () async {
      setUpMockGetRequestSuccess200("album.json");

      await albumRemoteDataSourceImpl.fetchById(tId);

      verify(mockClient
          .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$tId')));
    });

    test('should return a album from when the response code is 200', () async {
      setUpMockGetRequestSuccess200("album.json");

      final result = await albumRemoteDataSourceImpl.fetchById(tId);

      expect(result, equals(tAlbum));
    });

    test(
        'should throw a HttpOperationException when response code is greater than equal 400',
        () async {
      setUpMockGetRequestFailure400();

      final call = albumRemoteDataSourceImpl.fetchById;

      expect(
          () => call(tId), throwsA(const TypeMatcher<HttpRequestException>()));
    });
  });

  group('create', () {
    test('should verify a POST request', () async {
      when(mockClient.post(any, body: anyNamed("body"))).thenAnswer(
          (_) async => http.Response(json.encode("{'id': 101}"), 201));

      await albumRemoteDataSourceImpl.create(albumToCreate);

      verify(mockClient.post(
          Uri.parse("https://jsonplaceholder.typicode.com/albums"),
          body: json.encode(albumToCreate.toJson())));
    });

    test(
        'should throw a HttpOperationException when response code is greater than equal 400',
        () async {
      when(mockClient.post(any, body: anyNamed("body")))
          .thenAnswer((_) async => http.Response(errorMessage, 400));

      final call = albumRemoteDataSourceImpl.create;

      expect(() => call(albumToCreate),
          throwsA(const TypeMatcher<HttpRequestException>()));
    });
  });
}
