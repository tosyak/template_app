/// A base exception class for handling application-specific errors.
/// 
/// This abstract class provides a common structure for custom exceptions in the application,
/// allowing for a consistent way of representing and handling errors with an optional status code.
/// 
/// [message] contains a descriptive error message.
/// [statusCode] is an optional HTTP status code or error code associated with the exception.
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(super.message, [super.statusCode]);
}

class ServerException extends AppException {
  ServerException(super.message, [super.statusCode]);
}

class BadRequestException extends AppException {
  BadRequestException(super.message, [super.statusCode]);
}

class NotFoundException extends AppException {
  NotFoundException(super.message, [super.statusCode]);
}

class LocalStorageException extends AppException {
  LocalStorageException(super.message, [super.statusCode]);
}

class CacheException extends AppException {
  CacheException(super.message, [super.statusCode]);
}

class AppDatabaseException extends AppException {
  AppDatabaseException(super.message, [super.statusCode]);
}

class PlatformFeatureException extends AppException {
  PlatformFeatureException(super.message);
}
