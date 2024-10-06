import 'package:clean_architecture_tdd_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:clean_architecture_tdd_course/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [NumberTriviaScreen] represents the screen that displays number trivia,
/// allowing users to view trivia related to specific numbers or random trivia.
class NumberTriviaScreen extends StatelessWidget {
  ///  Default constructor that accepts an optional [key].
  const NumberTriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  /// Method to build body of [NumberTriviaScreen]
  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return const MessageDisplay(
                      message: 'Start searching!',
                    );
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                  return const MessageDisplay(
                    message: 'Start searching!',
                  );
                },
              ),
              const SizedBox(height: 20),
              const TriviaControls(),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3 - 31,
                child: Image.asset('assets/images/background.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
