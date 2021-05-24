import 'package:dartz/dartz.dart';
import 'package:jamoverflow/config/auth_types.dart';
import 'package:jamoverflow/core/error/failures.dart';
import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';

abstract class AuthContract {
  Future<Either<Failure, User>> signIn(
      AuthType authType, String email, String password);
  Future<Either<Failure, User>> signUp(String email, String password);
}
