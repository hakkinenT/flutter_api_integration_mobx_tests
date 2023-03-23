import '../http_request_error.dart';

class HttpRequestException implements Exception {
  final HttpRequestError httpError;

  HttpRequestException({required this.httpError});

  @override
  String toString() => httpError.toString();
}
