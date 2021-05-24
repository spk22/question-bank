import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class LoginDetails extends ChangeNotifier {
  bool saveStatus;
  String email;
  String password;

  Future<void> updateDetails() async {
    String boxName = 'user';
    var box = await Hive.openBox(boxName);
    saveStatus = box.get('isSaved', defaultValue: false);
    email = box.get('email');
    password = box.get('password');
    notifyListeners();
  }

  LoginDetails({this.saveStatus, this.email, this.password});
}
