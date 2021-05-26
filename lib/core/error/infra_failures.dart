import 'package:jamoverflow/core/error/exceptions.dart';
import 'package:jamoverflow/core/error/failure_interfaces.dart';

class DisconnectedFailure extends InfraFailure<DisconnectedException> {
  String _message;
  DisconnectedFailure(DisconnectedException e) : super(e) {
    _message = e.message;
  }

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class ServerFailure extends InfraFailure<ServerException> {
  String _message;
  ServerFailure(ServerException e) : super(e) {
    _message = e.message;
  }
  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class RoleMismatchFailure extends InfraFailure<RoleMismatchException> {
  String _message;
  RoleMismatchFailure(RoleMismatchException e) : super(e) {
    _message = e.message;
  }
  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class DefaultFailure extends InfraFailure<DefaultErrorException> {
  String _message;
  DefaultFailure(DefaultErrorException e) : super(e) {
    _message = e.message;
  }
  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

// Types of Failure messages
class InfraFailureMessage {
  static const String DISCONNECTED = "Device is not connected to internet";
  static const String SERVER_FAILED = "Backend Server is not running/reachable";
  static const String ROLE_MISMATCH =
      "Login Role mismatched. Try logging in with different Role.";
}
