part of 'number_trivia_bloc.dart';

/// States for the NumberTriviaBloc.
sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of the bloc, before any trivia is fetched.
final class Empty extends NumberTriviaState {}

/// Represents a loading state while fetching trivia data.
final class Loading extends NumberTriviaState {}

/// Represents a loaded state containing number trivia data.
final class Loaded extends NumberTriviaState {
  /// Constructor that initializes the state with the provided [trivia].
  const Loaded({required this.trivia});

  /// The trivia data that has been loaded.
  final NumberTrivia trivia;

  @override
  List<Object> get props => [trivia];
}

/// Represents an error state with an associated failure message.
final class Error extends NumberTriviaState {
  /// Constructor that initializes the error state with the provided [message].
  const Error({required this.message});

  /// The error message detailing the failure.
  final String message;

  @override
  List<Object> get props => [message];
}
