import 'dart:async';
import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:clean_architecture_tdd_course/core/usecases/usecase.dart';
import 'package:clean_architecture_tdd_course/core/utils/app_strings.dart';
import 'package:clean_architecture_tdd_course/core/utils/input_converter.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  // Necessary setup to use Params with mocktail null safety
  setUpAll(() {
    registerFallbackValue(const Params(number: 1));
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  // Check bloc initial state [I think not needed in new version of bloc]
  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    void setUpMockInputConverterSuccess() =>
        when(() => mockInputConverter.stringToUnsignedInteger(any()))
            .thenReturn(const Right(tNumberParsed));

    void setUpMockGetConcreteNumberTriviaSuccess() =>
        when(() => mockGetConcreteNumberTrivia(any()))
            .thenAnswer((_) async => const Right(tNumberTrivia));

    test(
        'should call the InputConverter to validate and convert the string to '
        'an unsigned integer', () async {
      // arrange
      setUpMockInputConverterSuccess();
      setUpMockGetConcreteNumberTriviaSuccess();

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      /*
        Executing the logic present inside [map event to state] takes some time,
        so if we don't wait, the verify inside this test will be executed
        before the stringToUnsignedInteger had chance to run within
        [map event to state]
        */
      await untilCalled(
        () => mockInputConverter.stringToUnsignedInteger(any()),
      );

      // assert
      verify(() => mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async {
      // arrange
      when(() => mockInputConverter.stringToUnsignedInteger(any()))
          .thenReturn(Left(InvalidInputFailure()));

      // assert later
      /* 
          Is it safe to add an event before registering expectation?
          what if the logic run faster than expectLater?
          so we are going to register expectLater before adding an event
        */
      final expected = [
        // The initial state is always emitted first, so we can omit Empty()
        // Empty(),
        const Error(message: invalidInputFailureMessage),
      ];
      // This will make all the values which we are trying to test
      // are actually emitted, this test will be put onhold up to 30 sec
      unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

    test('should get data from the concrete use case', () async {
      // arrange
      setUpMockInputConverterSuccess();
      setUpMockGetConcreteNumberTriviaSuccess();

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(() => mockGetConcreteNumberTrivia(any()));

      // assert
      verify(
        () => mockGetConcreteNumberTrivia(const Params(number: tNumberParsed)),
      );
    });

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
        // Testing with stream so it is better to write assert first then act

        // assert later
        final expected = [
          Loading(),
          const Loaded(trivia: tNumberTrivia),
        ];
        unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(() => mockGetConcreteNumberTrivia(any()))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Loading(),
          const Error(message: serverFailureMessage),
        ];
        unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error '
      'when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(() => mockGetConcreteNumberTrivia(any()))
            .thenAnswer((_) async => Left(CacheFailure()));

        // assert later
        final expected = [
          Loading(),
          const Error(message: cacheFailureMessage),
        ];
        unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );
  });

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    void setUpMockGetRandomNumberTriviaSuccess() =>
        when(() => mockGetRandomNumberTrivia(any()))
            .thenAnswer((_) async => const Right(tNumberTrivia));

    test('should get data from the random use case', () async {
      // arrange
      setUpMockGetRandomNumberTriviaSuccess();

      // act
      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(() => mockGetRandomNumberTrivia(any()));

      // assert
      verify(() => mockGetRandomNumberTrivia(NoParams()));
    });

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockGetRandomNumberTriviaSuccess();

        // Testing with stream so it is better to write assert first then act
        // assert later
        final expected = [
          Loading(),
          const Loaded(trivia: tNumberTrivia),
        ];
        unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(() => mockGetRandomNumberTrivia(any()))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Loading(),
          const Error(message: serverFailureMessage),
        ];
        unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      ' should emit [Loading, Error] with a proper message for the error when '
      'getting data fails',
      () async {
        // arrange
        when(() => mockGetRandomNumberTrivia(any()))
            .thenAnswer((_) async => Left(CacheFailure()));

        // assert later
        final expected = [
          Loading(),
          const Error(message: cacheFailureMessage),
        ];
        unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );
  });
}
