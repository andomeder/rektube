class AppException implements Exception {
  final String message;
  final String? code; 

  AppException(this.message, {this.code});

  @override
  String toString() => code != null ? 'AppException ($code): $message' : message;
}

class AuthException extends AppException {
  AuthException(String message, {String? code}) : super(message, code: code);
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}

class DatabaseException extends AppException {
   DatabaseException(String message) : super(message);
}

class PipedException extends AppException {
  PipedException(String message) : super(message);
}