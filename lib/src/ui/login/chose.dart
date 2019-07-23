import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sagrado_flutter/src/ui/bottom_navigation/bottom_navigation.dart';

import 'package:sagrado_flutter/src/ui/login/chose_place/chose_place.dart';
import 'package:sagrado_flutter/src/ui/login/chose_place/chose_place_provider.dart';
import 'package:sagrado_flutter/src/ui/profile/profile.dart';

class ChoseScreen extends StatelessWidget {
  const ChoseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: PlatformScaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              SizedBox(height: 120),
              Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: PlatformText(
                  'Выберите площадки, события и акции которых Вам интересны:',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.6),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              ChoseButton(
                Text(
                  'Выбрать сейчас',
                  style: TextStyle(
                      letterSpacing: 1, color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        builder: (context) => ChosePlaceNotifier(),
                        child: ChosePlaceScreen(),
                      ),
                    ),
                  );
                },
              ),
              ChoseButton(
                Text(
                  'Выбрать позже в настройках',
                  style: TextStyle(
                      letterSpacing: 1, color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WillPopScope(
                        onWillPop: () async {
                          return true;
                        },
                        child: CustomBottomNavigation(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoseButton extends StatelessWidget {
  const ChoseButton(
    this.title, {
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final Widget title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: OutlineButton(
          highlightedBorderColor: Colors.black,
          child: this.title,
          onPressed: this.onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.blueAccent[700],
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
      ),
    );
  }
}

//flutter: {"status":"success","token":"uCL8YmIccrvOOtYAKR6asMhLrcWs","push_token":"6d505530ffa1e55be7ce134919c90ff295bf03d1cc09384","os_type":"ios","user_id":123,"user":{"id":236,"username":"7901312312377","email":null,"created_at":"2019-04-21 16:16:27","updated_at":"2019-04-21 16:16:52","logined_at":null,"avatar":null,"push_subscribes":{"event":true,"news":true,"action":true},"email_subscribe":0,"admin":0,"user_devices":[{"id":319,"user_id":236,"push_token":"6d505530ffa1e55123123134919c123123123413123","push_settings":null,"created_at":"2019-04-21 16:16:27","updated_at":"2019-04-21 16:16:27","os_type":"ios"}]}}
