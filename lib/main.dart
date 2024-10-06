import 'package:clean_architecture_tdd_course/features/number_trivia/presentation/screens/number_trivia_screen.dart';
import 'package:clean_architecture_tdd_course/injection_container.dart' as di;
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const NumberTriviaApp());
}

/// The root widget of app
class NumberTriviaApp extends StatelessWidget {
  ///  Default constructor that accepts an optional [key].
  const NumberTriviaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff6A149C),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
        ),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
          secondary: Colors.purple.shade600,
        ),
      ),
      home: const NumberTriviaScreen(),
    );
  }
}
