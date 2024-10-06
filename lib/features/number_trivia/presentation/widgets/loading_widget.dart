import 'package:clean_architecture_tdd_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';

/// Represents a widget displayed when the state of the [NumberTriviaBloc] is
/// loading.
class LoadingWidget extends StatelessWidget {
  ///  Default constructor that accepts an optional [key].
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
