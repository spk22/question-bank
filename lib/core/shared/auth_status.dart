import 'package:flutter/foundation.dart';

enum AuthState {
  SERVER_FAILED,
  LOGIN_ROLE_MISMATCH,
  AUTH_SUCCESSFUL,
}

class AuthStatus {
  final bool success;
  final AuthState state;
  final String userId;

  AuthStatus({
    @required this.success,
    @required this.userId,
    @required this.state,
  });
}
