class HttpRequestError {
  final int statusCode;
  final String message;

  HttpRequestError({required this.statusCode, required this.message});

  @override
  String toString() => '''
  {
    error: {
      status_code: $statusCode,
      message: $message
    }
  }
''';
}
