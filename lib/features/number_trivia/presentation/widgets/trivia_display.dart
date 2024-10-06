import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/material.dart';

/// A widget that displays the number trivia information.
class TriviaDisplay extends StatelessWidget {
  /// Creates an instance of [TriviaDisplay] with the given [numberTrivia].
  const TriviaDisplay({
    required this.numberTrivia,
    super.key,
  });

  /// The [NumberTrivia] data to be displayed.
  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(
            numberTrivia.number.toString(),
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  numberTrivia.text,
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
