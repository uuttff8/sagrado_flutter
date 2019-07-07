

import 'package:flutter_keychain/flutter_keychain.dart';

class KeychainManager {
  KeychainManager._();
  static final KeychainManager shared = KeychainManager._();

  String _token = "TOKEN";

  String _error = "ERROR";

  FlutterKeychain _keychain;

  void auth({token: String}) {
    this._token = token;
  }

  void logout() {
    this._token = "";
  }

  bool _isTokenValid()  {
    // return this._token != this._error
  }

  String _setToken() {

  }
}