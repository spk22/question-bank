import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({String uid, String email, String password, bool isAdmin})
      : super(uid: uid, email: email, password: password, isAdmin: isAdmin);
}
