import 'package:shared_preferences/shared_preferences.dart';

class _PrefsKeys {
  static const String NOTIFICATIONS_KEY = "NOTIFICATIONS_KEY";
  static const String UUID = "UUID";
  static const String IS_REGISTERATION_PASSED = "IS_REGISTERATION_PASSED";
  static const String USER = "USER";
  static const String USER_CARD = "USER_CARD";
  static const String USER_CLUBS = "USER_CLUBS";
  static const String SUB_ON_EVENTS = "SUB_ON_EVENTS";
  static const String SUB_ON_NEWS = "SUB_ON_NEWS";
  static const String SUB_ON_ACTIONS = "SUB_ON_ACTIONS";
  static const String IS_FIRST_ASK_PUSH = "IS_FIRST_ASK_PUSH";
  static const String USER_TOKEN = "USER_TOKEN";
}

class Prefs {
  Prefs._privateConstructor();
  static final Prefs shared = Prefs._privateConstructor();

  void clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool clearStatus = await prefs.clear();

    if (clearStatus == false) {
      throw Exception("can't clear account");
    }
  }

  Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(_PrefsKeys.USER_TOKEN ?? "");
    return token;
  }

  void setUserToken({token: String}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PrefsKeys.USER_TOKEN, token);
  }

  Future<bool> getIsSubOnEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var subOnEvents = prefs.getBool(_PrefsKeys.SUB_ON_EVENTS);
    return subOnEvents;
  }

  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString(_PrefsKeys.USER ?? "");
    return user;
  }

  void setUser({String user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PrefsKeys.USER, user.toString());
  }

  Future<bool> getRegistrationPassed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_PrefsKeys.IS_REGISTERATION_PASSED ?? false);
  }

  void setRegistrationPassed(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_PrefsKeys.IS_REGISTERATION_PASSED, value);
  }
}
