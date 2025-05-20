/// An abstract base class representing a generic failure in the application.
///
/// [Failure] provides a common structure for different types of failures,
/// including an optional error message and status code.
///
/// Subclasses can represent specific types of failures like network, server, or cache errors.
abstract class Failure {
  final String message;
  final int? statusCode;

  Failure(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message, [super.statusCode]);
}

class ServerFailure extends Failure {
  ServerFailure(super.message, [super.statusCode]);
}

class CacheFailure extends Failure {
  CacheFailure(super.message, [super.statusCode]);
}
