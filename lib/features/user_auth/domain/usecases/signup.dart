import 'package:dartz/dartz.dart';
import 'package:jamoverflow/core/error/failure_interfaces.dart';
import 'package:jamoverflow/core/shared/usecase_interface.dart';
import 'package:jamoverflow/features/user_auth/domain/contracts/auth_contract.dart';
import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';

class SignUp implements UseCase<User, Param> {
  final AuthContract contract;

  SignUp(this.contract);

  @override
  Future<Either<InfraFailure<Exception>, User>> call(Param param) =>
      contract.signUp(param.email, param.password);
}

// this class holds user input data, for SignUp usecase
class Param {
  final String email;
  final String password;

  Param({this.email, this.password})
      : assert(email != null && password != null,
            "email & password can't be null");
}
