import 'package:flutter/foundation.dart';
import 'package:jamoverflow/config/auth_types.dart';
import 'package:jamoverflow/core/error/exceptions.dart';
import 'package:jamoverflow/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:jamoverflow/core/shared/network_info.dart';
import 'package:jamoverflow/features/user_auth/data/datasources/auth_datasource.dart';
import 'package:jamoverflow/features/user_auth/domain/contracts/auth_contract.dart';
import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';

class Auth implements AuthContract {
  final AuthDataSourceContract dataSource;
  final NetworkInfoContract networkInfo;

  Auth({@required this.dataSource, @required this.networkInfo});

  Future<Either<Failure, User>> _executePassedAuth(
      Future<User> Function() passAuth) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await passAuth();
        return Right(userModel);
      } on ServerException {
        return Left(Failure(FailureMessage.SERVER_FAILED));
      } on RoleMismatchException {
        return Left(Failure(FailureMessage.ROLE_MISMATCH));
      } on DefaultErrorException {
        return Left(Failure(FailureMessage.DEFAULT_MESSAGE));
      }
    } else {
      return Left(Failure(FailureMessage.DISCONNECTED));
    }
  }

  @override
  Future<Either<Failure, User>> signIn(
      AuthType authType, String email, String password) async {
    return await _executePassedAuth(
        () => dataSource.signIn(authType, email, password));
  }

  @override
  Future<Either<Failure, User>> signUp(String email, String password) async {
    return await _executePassedAuth(() => dataSource.signUp(email, password));
  }
}
