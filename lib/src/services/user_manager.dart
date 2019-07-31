import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:meta/meta.dart';
import 'package:sagrado_flutter/src/model/model.dart';
import 'package:sagrado_flutter/src/services/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  UserManager._();
  static final UserManager instance = UserManager._();

  static void saveUser(User user) {
    String jsonData = json.encode(user.toString());
    debugPrint(jsonData);
    Prefs.shared.setUser(user: jsonData);
  }

  static Future<User> getUser() async {
    String temp = await Prefs.shared.getUser();
    return User.fromJson(json.decode(temp));
  }

  static Future<bool> isRegistrationDone() async {
    return await Prefs.shared.getRegistrationPassed();
  }

  static void setUserDoneRegistration(bool value) {
    Prefs.shared.setRegistrationPassed(value);
  }

  static void auth({@required String token}) {
    FlutterKeychain.put(key: 'token', value: token);
  }

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await prefs.clear() != true) {
      print('Shared Preferences clear is not succesfull');
    }
    await FlutterKeychain.clear();
  }
}
