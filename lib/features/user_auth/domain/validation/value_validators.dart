import 'package:dartz/dartz.dart';
import 'package:jamoverflow/core/error/failure_interfaces.dart';
import 'package:jamoverflow/features/user_auth/domain/validation/value_failures.dart';

Either<ValueFailure<String>, String> validateUserId(String uid) {
  if (uid != null)
    return right(uid);
  else
    return left(NullUserIdFailure(uid));
}
