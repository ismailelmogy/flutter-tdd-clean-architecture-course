import 'package:equatable/equatable.dart';

/// Entity representing number trivia with a [text] description and a [number].
class NumberTrivia extends Equatable {
  /// Creates a new [NumberTrivia] with the provided [text] and [number].
  const NumberTrivia({required this.text, required this.number});

  /// Text description of the trivia.
  final String text;

  /// The number associated with the trivia.
  final int number;

  @override
  List<Object?> get props => [text, number];
}
