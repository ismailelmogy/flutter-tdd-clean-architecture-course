import 'dart:convert';
import 'package:clean_architecture_tdd_course/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_course/core/utils/app_strings.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Contract for the local data source responsible for caching and retrieving
/// number trivia.
abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Cache Number Trivia when the internet connection is present.
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

/// Concrete class that implements the [NumberTriviaLocalDataSource] abstract
/// class.This class uses [SharedPreferences] to cache and retrieve number
/// trivia.
class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  /// Constructor that accepts an instance of [SharedPreferences].
  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  /// Instance of [SharedPreferences] for caching and retrieving number trivia.
  final SharedPreferences sharedPreferences;

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedNumberTrivia);
    if (jsonString != null) {
      return Future.value(
        NumberTriviaModel.fromJson(
          json.decode(jsonString) as Map<String, dynamic>,
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      cachedNumberTrivia,
      json.encode(triviaToCache.toJson()),
    );
  }
}
