import 'package:equatable/equatable.dart';

/// A generic abstract class representing failures in the application.
abstract class Failure extends Equatable {
  /// Override the props to ensure that equality comparison is based on the
  /// object's properties.
  @override
  List<Object> get props => [];
}

/// Represents a failure related to server issues.
class ServerFailure extends Failure {}

/// Represents  a failure related to local caching operations
class CacheFailure extends Failure {}
