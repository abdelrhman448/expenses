import 'package:dio/dio.dart';
import 'package:expenses/core/extensions/extension_util/string_extension.dart';
import 'error_model.dart';

class ErrorHandler {
  ErrorModel responseExceptionHandler(Response e) {

    switch (e.statusCode) {
      case 400:
        return ErrorModel(code: 400, message:e.data["message"]?? "bad_request_error");
      case 401:
        return ErrorModel(code: 401, message: e.data["message"]??"unauthorized_error");
      case 403:
        throw ErrorModel(code: 403, message:e.data["message"]??"forbidden_error");
      case 404:

        return ErrorModel(code: 404, message: e.data["message"]??"noDataFound");
      case 409:
        return ErrorModel(code: 409, message: e.data["message"]??"conflict_error");

      case 500:
      case 501:
      case 502:
      case 504:
      case 505:
        return ErrorModel(code: 500, message:e.data["message"]?? "server_error");
      default:
        return ErrorModel(code: 0, message: "unexpected");
    }
  }

}
