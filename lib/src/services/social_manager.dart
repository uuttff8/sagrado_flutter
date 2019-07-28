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
}

class SocialType {
  final String vk = "vk";
  final String fb = "facebook";
}

class SocialManager {}

class FbManager {
  var facebookLogin = FacebookLogin();

  void authorize(
      void onSuccess(SocialData data), void onError(String error)) async {
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email', 'user_photos']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print('some error');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('cancelled by user');
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        print(facebookLoginResult.accessToken.token);
        break;
    }
  }
}
