// Repository will catch these exceptions and will transform them into Failures
import 'package:flutter/foundation.dart';

class DisconnectedException implements Exception {
  final String message;

  DisconnectedException({@required this.message});
}

class ServerException implements Exception {
  final String message;

  ServerException({@required this.message});
}

class RoleMismatchException implements Exception {
  final String message;

  RoleMismatchException({@required this.message});
}

class DefaultErrorException implements Exception {
  final String message;

  DefaultErrorException({@required this.message});
}
