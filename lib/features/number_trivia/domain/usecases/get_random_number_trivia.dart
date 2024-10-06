import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:clean_architecture_tdd_course/core/usecases/usecase.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

/// Use case to fetch random number trivia.
class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  /// Constructor that takes the [NumberTriviaRepository].
  GetRandomNumberTrivia(this.numberTriviaRepository);

  /// Repository to fetch the number trivia.
  final NumberTriviaRepository numberTriviaRepository;

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams noParams) async =>
      numberTriviaRepository.getRandomNumberTrivia();
}
