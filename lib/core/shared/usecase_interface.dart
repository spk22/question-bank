import 'package:dartz/dartz.dart';
import 'package:jamoverflow/core/error/failure_interfaces.dart';

abstract class UseCase<Type, Param> {
  Future<Either<InfraFailure<Exception>, Type>> call(Param param);
}
