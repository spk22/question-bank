import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final bool isAdmin;
  final String uid;
  final String email;
  final String password;

  User({
    this.uid,
    @required this.email,
    @required this.password,
    @required this.isAdmin,
  });
  @override
  List<Object> get props => [uid];
}
