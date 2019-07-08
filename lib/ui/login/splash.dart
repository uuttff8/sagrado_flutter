import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/services.dart';
import 'package:sagrado_flutter/net/net_manager.dart';
import 'package:sagrado_flutter/ui/login/code.dart';
import 'package:sagrado_flutter/widgets/auth.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final MaskedTextController controller = MaskedTextController(mask: '+7(000)-000-0000');

  Image _imageAsset = Image.asset('assets/images/checkLogin.png');

  bool _isAgree = true;

  void checkAgreement() {
    if (_isAgree == true) {
      setState(() {
        _imageAsset = Image.asset('assets/images/uncheckLogin.png');
      });
      _isAgree = false;
    } else {
      setState(() {
        _imageAsset = Image.asset('assets/images/checkLogin.png');
      });
      _isAgree = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.black));
    AuthTextField authTextField = AuthTextField(controller: controller);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: PlatformScaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
              color: Colors.black,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/loginScreen.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                    child: SafeArea(
                      child: Container(
                        padding: const EdgeInsets.only(top: 40.0),
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ВОЙТИ',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 36),
                            ),
                            SizedBox(height: 40.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                              child: Text(
                                'Используйте аккаунты ВК или Facebook для вода в аккаунт',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            SizedBox(
                              width: 250,
                              child: authTextField,
                            ),
                            SizedBox(height: 40),
                            AuthButton(
                              Text(
                                'Вконтакте',
                                style: TextStyle(fontSize: 15, letterSpacing: 1.5, color: Colors.white),
                              ),
                              color: Color(
                                0xff4c75a3,
                              ),
                              onPressed: () {},
                            ),
                            AuthButton(
                              Text(
                                'Facebook',
                                style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff3b5999),
                              onPressed: () {},
                            ),
                            SizedBox(height: 50),
                            SizedBox(
                              height: 70,
                              width: 300,
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    iconSize: 15,
                                    icon: _imageAsset,
                                    onPressed: () {
                                      checkAgreement();
                                    },
                                  ),
                                  CupertinoButton(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: 'Я принимаю условия\n', style: TextStyle(color: Colors.white)),
                                          TextSpan(
                                            text: 'Лицензионного соглашения',
                                            style: TextStyle(color: Colors.blueAccent),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                            new LoginPhoneButton(authTextField: authTextField),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LoginPhoneButton extends StatelessWidget {
  const LoginPhoneButton({
    Key key,
    @required this.authTextField,
  }) : super(key: key);

  final AuthTextField authTextField;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
              border: Border.fromBorderSide(BorderSide(color: Colors.blue)),
              borderRadius: BorderRadius.all(Radius.circular(3))),
          child: RaisedButton(
            child: Text(
              'Войти',
              style: TextStyle(color: Colors.blue),
            ),
            color: Colors.transparent,
            onPressed: () async {
              if (authTextField.controller.text.length == 16) {
                try {
                  // NetManager.singleton
                  //     .signInPhone(phone: authTextField.controller.text)
                  //     .whenComplete(
                  //   () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => CodeScreen(
                  //           phone: authTextField.controller.text,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );

                  var response = await NetManager.shared.signInPhone(phone: authTextField.controller.text);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CodeScreen(
                        isNew: response.isNew,
                        phone: response.username,
                      ),
                    ),
                  );
                } catch (e) {
                  print('done: $e');
                }
              } else if (authTextField.controller.text.length != 16) {
                phoneTextIncomplete(context);
              }
            },
          ),
        ),
      ),
    );
  }

  void phoneTextIncomplete(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text('Предупреждение'),
        content: Text('Вы должны ввести правильный номер телефона'),
        actions: <Widget>[
          PlatformDialogAction(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
