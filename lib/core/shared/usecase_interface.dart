import 'package:dartz/dartz.dart';
import 'package:jamoverflow/core/error/failures.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}
