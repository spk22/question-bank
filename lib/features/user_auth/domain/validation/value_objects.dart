import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:jamoverflow/core/error/failure_interfaces.dart';
import 'package:jamoverflow/features/user_auth/domain/validation/value_validators.dart';

@immutable
abstract class ValueObject<T> extends Equatable {
  const ValueObject();
}

class UserId extends ValueObject<String> {
  final Either<ValueFailure<String>, String> value;

  const UserId._(this.value);

  factory UserId(String uid) {
    // assert(uid != null);
    return UserId._(validateUserId(uid));
  }

  @override
  List<Object> get props => [value];
}
