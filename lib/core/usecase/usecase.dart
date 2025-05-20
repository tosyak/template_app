import 'package:dartz/dartz.dart';
import 'package:ricknotmorty/core/error/failures.dart';

/// An abstract base class representing a use case in the application's clean architecture.
///
/// [Type] represents the return type of the use case.
/// [Params] represents the input parameters for the use case.
///
/// Implementing classes should provide a concrete implementation of the [call] method
/// to define the specific business logic for the use case.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Represents an empty parameter set for use cases that do not require any input parameters.
class NoParams {}

/// An extension on the [Either] type to provide convenient methods for extracting values.
///
/// This extension adds utility methods to easily retrieve the left or right value
/// from an [Either] instance, simplifying pattern matching and value extraction.
extension EitherX<L, R> on Either<L, R> {
  R getRight() => (this as Right<L, R>).value;
  L getLeft() => (this as Left<L, R>).value;
}
