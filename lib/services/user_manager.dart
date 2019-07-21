import 'dart:convert';
import 'package:sagrado_flutter/model/model.dart';
import 'package:sagrado_flutter/services/prefs.dart';

class UserManager {
  UserManager._();
  static final UserManager instance = UserManager._();

  void saveUser(User user) {
    String jsonData = json.encode(user.toString());
    Prefs.shared.setUser(user: jsonData);
  }

  void setUserDoneRegistration(bool value) {
    Prefs.shared.setRegistrationPassed(value);
  }
}
