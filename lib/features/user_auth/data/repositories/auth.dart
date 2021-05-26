import 'package:flutter/foundation.dart';
import 'package:jamoverflow/config/auth_types.dart';
import 'package:jamoverflow/core/error/exceptions.dart';
import 'package:jamoverflow/core/error/failure_interfaces.dart';
import 'package:jamoverflow/core/error/infra_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:jamoverflow/features/user_auth/data/datasources/auth_datasource.dart';
import 'package:jamoverflow/features/user_auth/data/models/user_model.dart';
import 'package:jamoverflow/features/user_auth/domain/contracts/auth_contract.dart';
import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';
import 'package:jamoverflow/features/user_auth/domain/validation/value_objects.dart';

class Auth implements AuthContract {
  final AuthDataSourceContract dataSource;

  Auth({@required this.dataSource});

  Future<Either<InfraFailure<Exception>, User>> _executePassedAuth(
      Future<UserModel> Function() passAuth) async {
    try {
      final userModel = await passAuth();
      // return Right(userModel);
      return Right(
        User(
          uid: UserId(userModel.uid),
          email: userModel.email,
          password: userModel.password,
          isAdmin: userModel.isAdmin,
        ),
      );
    } on DisconnectedException catch (e) {
      return Left(DisconnectedFailure(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e));
    } on RoleMismatchException catch (e) {
      return Left(RoleMismatchFailure(e));
    } on DefaultErrorException catch (e) {
      return Left(DefaultFailure(e));
    }
  }

  @override
  Future<Either<InfraFailure<Exception>, User>> signIn(
      AuthType authType, String email, String password) async {
    return await _executePassedAuth(
        () => dataSource.signIn(authType, email, password));
  }

  @override
  Future<Either<InfraFailure<Exception>, User>> signUp(
      String email, String password) async {
    return await _executePassedAuth(() => dataSource.signUp(email, password));
  }
}
