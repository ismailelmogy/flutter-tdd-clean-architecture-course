import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:clean_architecture_tdd_course/core/usecases/usecase.dart';
import 'package:clean_architecture_tdd_course/core/utils/app_strings.dart';
import 'package:clean_architecture_tdd_course/core/utils/input_converter.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

/// A class responsible for handling number trivia operations.
class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  /// Constructor that accepts instances of [GetConcreteNumberTrivia],
  /// [GetRandomNumberTrivia], and [InputConverter].
  NumberTriviaBloc({
    required GetConcreteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required this.inputConverter,
  })  : getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(Empty()) {
    /*
      async gives you a Future
      async* gives you a Stream.
    */
    // on<NumberTriviaEvent>((event, emit) {
    //   if (event is GetTriviaForConcreteNumber) {
    //     final inputEither =
    //         inputConverter.stringToUnsignedInteger(event.numberString);
    //     /* yield:
    //       adds a value to the output stream of the surrounding async*
    // function.    It's like returning value but doesn't terminate the function
    //     */
    //
    //     inputEither.fold((failure) async* {
    //       yield const Error(message: INVALID_INPUT_FAILURE_MESSAGE);
    //     }, (integer) => throw UnimplementedError());
    //   }
    // });

    on<GetTriviaForConcreteNumber>(_getTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_getTriviaForRandomNumber);
  }

  /// Use case for fetching trivia related to a specific number.
  final GetConcreteNumberTrivia getConcreteNumberTrivia;

  /// Use case for fetching random number trivia.
  final GetRandomNumberTrivia getRandomNumberTrivia;

  /// Converts input strings to integers.
  final InputConverter inputConverter;

  Future<void> _getTriviaForConcreteNumber(
    GetTriviaForConcreteNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);
    await inputEither.fold(
        (failure) async =>
            emit(const Error(message: invalidInputFailureMessage)),
        (integer) async {
      emit(Loading());
      final failureOrTrivia =
          await getConcreteNumberTrivia(Params(number: integer));
      _eitherLoadedOrErrorState(failureOrTrivia, emit);
    });
  }

  Future<void> _getTriviaForRandomNumber(
    GetTriviaForRandomNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    _eitherLoadedOrErrorState(failureOrTrivia, emit);
  }

  void _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> failureOrTrivia,
    Emitter<NumberTriviaState> emit,
  ) {
    failureOrTrivia.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (trivia) => emit(Loaded(trivia: trivia)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return serverFailureMessage;
      case const (CacheFailure):
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
