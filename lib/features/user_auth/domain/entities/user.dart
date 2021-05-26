import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:jamoverflow/features/user_auth/domain/validation/value_objects.dart';

class User extends Equatable {
  final bool isAdmin;
  final UserId uid;
  final String email;
  final String password;

  const User({
    this.uid,
    @required this.email,
    @required this.password,
    @required this.isAdmin,
  });
  @override
  List<Object> get props => [email, password, isAdmin];
}
