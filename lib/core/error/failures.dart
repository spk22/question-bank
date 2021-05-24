import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Types of Failure messages
class FailureMessage {
  static const String DISCONNECTED = "Device is not connected to internet";
  static const String SERVER_FAILED = "Backend Server is not running/reachable";
  static const String ROLE_MISMATCH =
      "Login Role mismatched. Try logging in with different Role.";
  static String DEFAULT_MESSAGE;
}
