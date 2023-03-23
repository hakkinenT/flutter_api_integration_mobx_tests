import '../../error/http_request_error.dart';

HttpRequestError mapStatusCodeToMessage(int statusCode) {
  switch (statusCode) {
    case 400:
      return HttpRequestError(
          statusCode: statusCode, message: "Invalid Request");
    case 401:
      return HttpRequestError(
          statusCode: statusCode, message: "Client not authenticated");
    case 403:
      return HttpRequestError(
          statusCode: statusCode, message: "Client not have authorization");
    case 404:
      return HttpRequestError(
          statusCode: statusCode, message: "Resource Not Found");
    case 500:
      return HttpRequestError(
          statusCode: statusCode, message: "Error in the Server");
    default:
      return HttpRequestError(statusCode: statusCode, message: "Unknow Error");
  }
}
