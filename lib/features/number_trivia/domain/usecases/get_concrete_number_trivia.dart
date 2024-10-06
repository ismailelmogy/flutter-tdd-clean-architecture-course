import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:clean_architecture_tdd_course/core/usecases/usecase.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Use case to fetch trivia for a specific number.
class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  /// Constructor that takes the [NumberTriviaRepository].
  GetConcreteNumberTrivia(this.numberTriviaRepository);

  /// Repository to fetch the number trivia.
  final NumberTriviaRepository numberTriviaRepository;

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async =>
      numberTriviaRepository.getConcreteNumberTrivia(params.number);
}

/// Parameters for the [GetConcreteNumberTrivia] use case.
class Params extends Equatable {
  /// Constructor to initialize [number].
  const Params({required this.number});

  /// The number to fetch trivia for.
  final int number;

  @override
  List<Object?> get props => [number];
}
