import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfoContract {
  Future<bool> get isConnected;
}

class NetworkInfo implements NetworkInfoContract {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfo(this.internetConnectionChecker);
  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
