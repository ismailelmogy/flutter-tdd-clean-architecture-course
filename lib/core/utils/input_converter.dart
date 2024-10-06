import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:dartz/dartz.dart';

/// A class that provides logic for converting a [String] to an unsigned [int].
/// It throws a [FormatException] when an invalid number is provided.
class InputConverter {
  /// Converts a [String] to an unsigned [int].
  ///
  /// Returns a [Right] with the converted integer if successful,
  /// or a [Left] with an [InvalidInputFailure] if the input is invalid.
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

/// Represents a failure related to [FormatException]
/// when an invalid number is provided.
class InvalidInputFailure extends Failure {}
