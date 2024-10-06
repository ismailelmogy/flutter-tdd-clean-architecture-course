part of 'number_trivia_bloc.dart';

/// Events for the NumberTriviaBloc
sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

/// Event to fetch trivia for a specific concrete number.
class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  /// Constructor that accepts the [numberString] to fetch trivia for.
  const GetTriviaForConcreteNumber(this.numberString);

  /// The number represented as a string to fetch trivia for.
  final String numberString;
  @override
  List<Object> get props => [numberString];
}

/// Event to fetch random trivia.
class GetTriviaForRandomNumber extends NumberTriviaEvent {}
