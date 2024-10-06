import 'dart:convert';
import 'package:clean_architecture_tdd_course/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_course/core/utils/app_strings.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockSharedPrefernces extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPrefernces mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPrefernces();
    dataSource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final tNumberTrivia = NumberTriviaModel.fromJson(
      json.decode(fixture('trivia_cached.json')) as Map<String, dynamic>,
    );

    test(
        'should return NumberTrivia from SharedPrefernces when there is one in '
        'cache', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(fixture('trivia_cached.json'));

      // act
      final result = await dataSource.getLastNumberTrivia();

      // assert
      verify(() => mockSharedPreferences.getString(cachedNumberTrivia));
      expect(result, tNumberTrivia);
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      // act
      final call = dataSource.getLastNumberTrivia;

      // assert
      expect(call, throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: 1);

    test('should call SharedPreferences to cache the data', () async {
      // arrange
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true); // Mock the return type of setString()

      // act
      await dataSource.cacheNumberTrivia(tNumberTriviaModel);

      // assert
      verify(
        () => mockSharedPreferences.setString(
          cachedNumberTrivia,
          expectedJsonString,
        ),
      );
    });
  });
}
