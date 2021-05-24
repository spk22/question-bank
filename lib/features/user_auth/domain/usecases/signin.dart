import 'package:jamoverflow/config/auth_types.dart';
import 'package:jamoverflow/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:jamoverflow/core/shared/usecase_interface.dart';
import 'package:jamoverflow/features/user_auth/domain/contracts/auth_contract.dart';
import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';

class SignIn implements UseCase<User, Param> {
  final AuthContract contract;

  SignIn(this.contract);

  @override
  Future<Either<Failure, User>> call(Param param) async {
    return await contract.signIn(param.authType, param.email, param.password);
  }
}

// this class holds user input data, for SignUp usecase
class Param {
  final AuthType authType;
  final String email;
  final String password;

  Param({this.authType, this.email, this.password})
      : assert(email != null && password != null,
            "email & password can't be null");
}
