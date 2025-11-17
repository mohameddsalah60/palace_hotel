abstract class CustomException implements Exception {
  final String message;
  final String? code;

  const CustomException({required this.message, this.code});
}

class NetworkException extends CustomException {
  const NetworkException({
    super.message = "Network error occurred",
    super.code,
  });
}

class ServerException extends CustomException {
  const ServerException({super.message = "Server error occurred", super.code});
}

class DatabaseConnectionException extends CustomException {
  const DatabaseConnectionException({
    super.message = "Database error occurred",
    super.code,
  });
}

class AuthException extends CustomException {
  const AuthException({
    super.message = "Authentication error occurred",
    super.code,
  });
}

class UnknownException extends CustomException {
  const UnknownException({super.message = "Unknown error occurred"});
}
