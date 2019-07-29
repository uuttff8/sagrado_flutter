import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class MetaUser {
  String userName, lastName, email;
  MetaUser({this.userName, this.lastName, this.email});
}

class SocialData {
  String token, userId;
  MetaUser metaUser;
  SocialData({this.token, this.userId, this.metaUser});
}

class SocialCallback {
  SocialData data;
  String error;
  SocialCallback({this.data, this.error});
}

enum SocialType {
  facebook,
}

class SocialManager {
  var _fbManager = FbManager();

  void authSocial({SocialType social, void callback(SocialCallback callback)}) {
    switch (social) {
      case SocialType.facebook:
        _authFb(callback: callback);
    }
  }

  void _authFb({void callback(SocialCallback callback)}) {
    _fbManager.authorize(onSuccess: (SocialData data) {
      callback(SocialCallback(data: data, error: null));
    }, onError: (String error) {
      callback(SocialCallback(data: null, error: error));
    });
  }
}

class FbManager {
  var facebookLogin = FacebookLogin();

  void authorize(
      {void onSuccess(SocialData data), void onError(String error)}) async {
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email', 'user_photos']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onError("Что-то пошло не так");
        break;
      case FacebookLoginStatus.cancelledByUser:
        onError("Что-то пошло не так");
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);

        onSuccess(
          SocialData(
            token: facebookLoginResult.accessToken.token,
            userId: facebookLoginResult.accessToken.userId,
            metaUser: MetaUser(
              userName: profile['first_name'],
              lastName: profile['last_name'],
              email: profile['email'],
            ),
          ),
        );
        break;
    }
  }
}
