import 'package:jamoverflow/config/auth_types.dart';
import 'package:jamoverflow/constants/app_keys.dart';
import 'package:jamoverflow/core/error/exceptions.dart';
import 'package:jamoverflow/core/error/failures.dart';
import 'package:jamoverflow/core/shared/auth_status.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseService {
  Parse _server;

  ParseService() {
    _server = Parse();
  }
  Future<void> initServer() async {
    await _server.initialize(
      AppKeys.APP_ID,
      AppKeys.APP_SERVER_URL,
      clientKey: AppKeys.APP_CLIENT_KEY,
      masterKey: AppKeys.APP_MASTER_KEY,
      autoSendSessionId: false,
      debug: false,
      liveQueryUrl: AppKeys.APP_LIVE_QUERY_URL,
      coreStore: await CoreStoreSharedPrefsImp.getInstance(),
    );
  }

  Future<bool> _isRunning() async {
    final ParseResponse parseResponse = await _server.healthCheck();
    return parseResponse.success;
  }

  Future<AuthStatus> signIn(
      AuthType authType, String email, String password) async {
    // if server not running, then return with AuthState.SERVER_FAILED
    // no need to proceed further
    if (!(await _isRunning())) {
      return AuthStatus(
          success: false, userId: null, state: AuthState.SERVER_FAILED);
    }
    AuthStatus status;
    final bool isAdmin = (authType == AuthType.admin);
    var queryBuilder = QueryBuilder<ParseUser>(ParseUser.forQuery())
      ..whereEqualTo('email', email);
    final ParseResponse response = await queryBuilder.query();
    if (response.count > 0) {
      final ParseObject record = response.results.first;
      if (record.get<bool>('isAdmin') != isAdmin) {
        // isAdmin mismatched
        return AuthStatus(
            success: false, userId: null, state: AuthState.LOGIN_ROLE_MISMATCH);
      }
    }
    final user = ParseUser(email, password, email);
    final authResponse = await user.login();
    if (authResponse.success) {
      status = AuthStatus(
        success: true,
        state: AuthState.AUTH_SUCCESSFUL,
        userId: user.objectId,
      );
    } else {
      FailureMessage.DEFAULT_MESSAGE = authResponse.error.message;
      throw DefaultErrorException();
    }

    return status;
  }

  Future<AuthStatus> signUp(String email, String password) async {
    // if server not running, then return with AuthState.SERVER_FAILED
    // no need to proceed further
    if (!(await _isRunning())) {
      return AuthStatus(
          success: false, userId: null, state: AuthState.SERVER_FAILED);
    }
    var user = ParseUser(email, password, email)..set('isAdmin', false);
    var response = await user.signUp();
    if (response.success) {
      // Ensure that the user does not log in until the email is confirmed.
      user = response.results.first;
      await user.logout();
      return AuthStatus(
          success: true, userId: null, state: AuthState.AUTH_SUCCESSFUL);
    } else {
      FailureMessage.DEFAULT_MESSAGE = response.error.message;
      throw DefaultErrorException();
    }
  }

  // Get ParseUser from objectId aka uid
  Future<ParseUser> _parseUserFromUid(String uid) async {
    final response = await ParseUser.forQuery().getObject(uid);
    ParseUser parseUser = (response.success) ? response.results.first : null;
    return parseUser;
  }

  Future<bool> signOut(String userId) async {
    final user = await _parseUserFromUid(userId);
    if (user == null) return true;
    final response = await user.logout();
    return response.success;
  }
}
