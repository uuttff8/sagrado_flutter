import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sagrado_flutter/src/model/model.dart';
import 'package:sagrado_flutter/src/net/net_manager.dart';
import 'package:sagrado_flutter/src/services/social_manager.dart';
import 'package:sagrado_flutter/src/services/user_manager.dart';
import 'package:sagrado_flutter/src/ui/login/complete_registration/complete_registration.dart';
import 'package:sagrado_flutter/src/ui/login/complete_registration/complete_registration_provider.dart';
import 'package:sagrado_flutter/src/ui/bottom_navigation/bottom_navigation.dart';

class SplashProvider with ChangeNotifier {
  BuildContext context;

  SplashProvider({this.context});

  var socialManager = SocialManager();
  var facebookLogin = FacebookLogin();

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

    onSocialLogin(data: response, metaUser: metaUser);
  }

  void onSocialLogin({AuthResponse data, MetaUser metaUser}) {
    UserManager.auth(token: data.token);
    if (data.user.isRegistered()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CustomBottomNavigation(data: data, metaUser: metaUser),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            builder: (BuildContext context) => CompleteRegistrationProvider(),
            child: CompleteRegistration(metaUser: metaUser),
          ),
        ),
      );
    }
  }
}
