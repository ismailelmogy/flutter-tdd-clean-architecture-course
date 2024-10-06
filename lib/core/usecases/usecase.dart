import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// A generic abstract class that defines the contract for use cases.
///
/// Use cases encapsulate specific operations that can be executed
/// in the application, allowing for separation of business logic
/// from other layers. Each use case must implement this class
/// to ensure consistent behavior across different operations.
///
/// [Type] - The type of the result that the use case returns.
/// [Params] - The type of parameters that the use case accepts.
abstract class UseCase<Type, Params> {
  /// An abstract method that each use case must implement.
  ///
  /// Naming it [call] allows the class to be invoked as a function,
  /// which is a feature of callable classes in Dart.
  ///
  /// Executes the use case with the provided parameters.
  ///
  /// Returns a [Future] that completes with an [Either] value,
  /// which can either be a [Failure] on the left side or the
  /// expected result of type [Type] on the right side.
  Future<Either<Failure, Type>> call(Params params);
}

/// A class that represents the absence of parameters for use cases.
///
/// Each use case that implements the [UseCase] contract can utilize
/// this class when no parameters are required.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
