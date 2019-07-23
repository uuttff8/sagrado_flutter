import 'dart:convert';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:sagrado_flutter/src/model/model.dart';
import 'package:sagrado_flutter/src/services/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  UserManager._();
  static final UserManager instance = UserManager._();

  void saveUser(User user) {
    String jsonData = json.encode(user.toString());
    print(jsonData);
    Prefs.shared.setUser(user: jsonData);
  }

  User getUser() {}

  void setUserDoneRegistration(bool value) {
    Prefs.shared.setRegistrationPassed(value);
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await prefs.clear() != true) {
      print('Shared Preferences clear is not succesfull');
    }
    await FlutterKeychain.clear();
  }
}
