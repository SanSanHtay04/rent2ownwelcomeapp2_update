class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);
  String toString() {
    return "$_prefix";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid Request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message, "403 error");
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, "Not Found");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input");
}

class ServerException extends AppException {
  ServerException([String? message]) : super(message, "Server Not Found");
}
