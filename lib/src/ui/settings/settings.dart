import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:provider/provider.dart';
import 'package:sagrado_flutter/src/services/user_manager.dart';
import 'package:sagrado_flutter/src/ui/login/splash/splash.dart';
import 'package:sagrado_flutter/src/ui/login/splash/splash_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // double _slider = 0.5;
  // bool _switch = false;
  // int _index = 0;

  @override
  Widget build(BuildContext context) {
    //CSWidgetStyle brightnessStyle = const CSWidgetStyle(
    //    icon: const Icon(Icons.brightness_medium, color: Colors.black54));
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Настройки',
          style: TextStyle(color: Colors.black),
        ),
        leading: PlatformButton(
          child: Icon(
            Icons.chevron_left,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: CupertinoSettings(
          items: <Widget>[
            CSHeader(''),
            CSButton(CSButtonType.DEFAULT, "Выберите площадки", () {}),
            CSHeader("Уведомления"),
            CSControl(
              'События',
              new CupertinoSwitch(
                value: true,
                onChanged: (bool v) {},
              ),
            ),
            CSControl(
              'Новости',
              new CupertinoSwitch(
                value: true,
                onChanged: (bool v) {},
              ),
            ),
            CSControl(
              'Акции',
              new CupertinoSwitch(
                value: true,
                onChanged: (bool v) {},
              ),
            ),
            CSHeader(""),
            CSButton(CSButtonType.DEFAULT, "Рассылки с уведомлениями", () {}),
            CSButton(CSButtonType.DEFAULT, "Написать разработчикам", () {}),
            CSHeader(""),
            CSButton(
              CSButtonType.DESTRUCTIVE,
              "Выйти из аккаунта",
              () {
                print("settings: logout!!!!");
                UserManager.instance.logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      builder: (_) => SplashProvider(),
                      child: SplashScreen(),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
