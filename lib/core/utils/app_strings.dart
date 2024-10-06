import 'package:shared_preferences/shared_preferences.dart';

/// A constant key used to identify the cached number trivia data in
///  [SharedPreferences]
const cachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';

/// Message indicating a server failure.
const String serverFailureMessage = 'Server Failure';

/// Message indicating a cache failure.
const String cacheFailureMessage = 'Cache Failure';

/// Message indicating an invalid input failure.
/// The number must be a positive integer or zero.
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero.';
