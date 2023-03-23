import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test_widget_integration_unit/error/exception/http_request_exception.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/map_status_code_to_message.dart';
import '../models/album.dart';

abstract class AlbumRemoteDataSource {
  Future<List<Album>> fetchAll();
  Future<Album> fetchById(int albumId);
  Future<void> create(Album album);
}

class AlbumRemoteDataSourceImpl implements AlbumRemoteDataSource {
  AlbumRemoteDataSourceImpl({required this.client});

  final http.Client client;

  final String _baseUrl = "https://jsonplaceholder.typicode.com/albums";

  @override
  Future<void> create(Album album) async {
    await _request(operation: () => _sendPostRequest(album));
  }

  Future<http.Response> _sendPostRequest(Album album) async {
    return await client.post(Uri.parse(_baseUrl),
        body: json.encode(album.toJson()));
  }

  @override
  Future<List<Album>> fetchAll() async {
    return await _request(
        operation: () => _sendGetRequest(_baseUrl),
        response: (httpResponse) => (json.decode(httpResponse.body) as List)
            .map<Album>((e) => Album.fromJson(e))
            .toList());
  }

  Future<http.Response> _sendGetRequest(String url) async {
    return await client.get(Uri.parse(url));
  }

  @override
  Future<Album> fetchById(int albumId) async {
    return await _request(
        operation: () => _sendGetRequest('$_baseUrl/$albumId'),
        response: (httpResponse) =>
            Album.fromJson(json.decode(httpResponse.body)));
  }

  _request(
      {required Future<http.Response> Function() operation,
      Function(http.Response)? response}) async {
    late http.Response httpResponse;
    try {
      httpResponse = await operation();

      _throwHttpOperationExceptionOnResponseNotSuccess(httpResponse.statusCode);

      if (response != null) return response(httpResponse);
    } on SocketException {
      rethrow;
    } on TimeoutException {
      rethrow;
    }
  }

  _throwHttpOperationExceptionOnResponseNotSuccess(int statusCode) {
    if (_isResponseNotSuccess(statusCode)) {
      throw HttpRequestException(httpError: mapStatusCodeToMessage(statusCode));
    }
  }

  bool _isResponseNotSuccess(int statusCode) {
    bool isStatusCodeNotSuccess = (statusCode >= 400) && (statusCode <= 500);

    return isStatusCodeNotSuccess;
  }
}
