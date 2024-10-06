import 'package:data_connection_checker_tv/data_connection_checker.dart';

/// A generic abstract class responsible for checking network connectivity.
abstract class NetworkInfo {
  /// Checks if the device is currently connected to the network.
  Future<bool> get isConnected;
}

/// Concrete class that implements the [NetworkInfo] abstract class.
/// This class uses [DataConnectionChecker] to check the device's network
/// connectivity.
class NetworkInfoImpl implements NetworkInfo {
  /// Constructor that accepts an instance of [DataConnectionChecker].
  NetworkInfoImpl(this.dataConnectionChecker);

  /// Instance of [DataConnectionChecker] for checking network connectivity.
  final DataConnectionChecker dataConnectionChecker;

  /// Method to check whether the device is connected to the network or not.
  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
