import 'package:flutter/services.dart';
import 'package:jamoverflow/config/auth_types.dart';
import 'package:jamoverflow/core/error/exceptions.dart';
import 'package:jamoverflow/core/error/infra_failures.dart';
import 'package:jamoverflow/core/services/parse_service.dart';
import 'package:jamoverflow/core/shared/auth_status.dart';
import 'package:jamoverflow/core/shared/network_info.dart';
import 'package:jamoverflow/features/user_auth/data/models/user_model.dart';

abstract class AuthDataSourceContract {
  Future<UserModel> signIn(AuthType authType, String email, String password);
  Future<UserModel> signUp(String email, String password);
}

class AuthDataSource implements AuthDataSourceContract {
  final ParseService service;
  final NetworkInfoContract networkInfo;

  AuthDataSource({this.service, this.networkInfo});

  @override
  Future<UserModel> signIn(
      AuthType authType, String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final authStatus = await service.signIn(authType, email, password);
        if (authStatus.state == AuthState.SERVER_FAILED) {
          throw ServerException(message: InfraFailureMessage.SERVER_FAILED);
        } else if (authStatus.state == AuthState.LOGIN_ROLE_MISMATCH) {
          throw RoleMismatchException(
              message: InfraFailureMessage.ROLE_MISMATCH);
        } else {
          return UserModel(
            uid: authStatus?.userId,
            email: email,
            password: password,
            isAdmin: (authType == AuthType.admin),
          );
        }
      } catch (e) {
        if (e is PlatformException) {
          throw DefaultErrorException(message: e.message);
        } else
          rethrow;
      }
    } else {
      throw DisconnectedException(message: InfraFailureMessage.DISCONNECTED);
    }
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final AuthStatus authStatus = await service.signUp(email, password);
        // check if authStatus.state is SERVER_FAILED or AUTH_SUCCESSFUL
        if (authStatus.state == AuthState.SERVER_FAILED) {
          throw ServerException(message: InfraFailureMessage.SERVER_FAILED);
        }
        return UserModel(email: email, password: password);
      } catch (e) {
        if (e is PlatformException) {
          throw DefaultErrorException(message: e.message);
        } else
          rethrow;
      }
    } else {
      throw DisconnectedException(message: InfraFailureMessage.DISCONNECTED);
    }
  }
}
