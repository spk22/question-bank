import 'package:dartz/dartz.dart';
import 'package:jamoverflow/config/auth_types.dart';
import 'package:jamoverflow/core/error/failure_interfaces.dart';
import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';

abstract class AuthContract {
  Future<Either<InfraFailure<Exception>, User>> signIn(
      AuthType authType, String email, String password);
  Future<Either<InfraFailure<Exception>, User>> signUp(
      String email, String password);
}
