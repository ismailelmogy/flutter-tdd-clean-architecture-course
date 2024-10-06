import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

/// Contract for fetching concrete or random number trivia.
abstract class NumberTriviaRepository {
  /// Fetches trivia for a specific [number].
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);

  /// Fetches random number trivia.
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
