import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:sagrado_flutter/src/model/model.dart';
import 'package:sagrado_flutter/src/net/net_manager.dart';
import 'package:sagrado_flutter/src/services/social_manager.dart';
import 'package:sagrado_flutter/src/ui/login/splash/splash.dart';

class SplashProvider with ChangeNotifier {
  var socialManager = SocialManager();
  var facebookLogin = FacebookLogin();

  SplashScreenState _providerView = SplashScreenState();

  void initiateFacebookLogin() {
    loginSocial(social: SocialType.facebook);
  }

  void loginSocial({SocialType social}) {
    socialManager.authSocial(
      social: social,
      callback: (SocialCallback callback) {
        if (callback.data != null) {
          print('BLBLBLLBLBLBLBL');
          loginAfterSocial(
            social: social,
            userId: callback.data.userId,
            socialToken: callback.data.token,
            metaUser: callback.data.metaUser,
          );
        } else {
          print('LALLLALALALAL');
          if (callback.error != null) {/*showError(text: error) }*/}
        }
      },
    );
  }

  void loginAfterSocial({
    SocialType social,
    String userId,
    String socialToken,
    metaUser: MetaUser,
  }) async {
    String socialString = social.toString().split('.').last;

    var response = await NetManager.shared.getToken(
      social: socialString, // fuck that shit
      userId: userId ?? "",
      pushToken: null,
      socialToken: socialToken,
      metaUser: metaUser,
    );

    _providerView.onSocialLogin(data: response);
  }
}
