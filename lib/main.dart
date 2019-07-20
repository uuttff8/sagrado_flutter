import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'ui/login/splash.dart';

void main() {
  runApp(SagradoApp());
}

class SagradoApp extends StatelessWidget {
  const SagradoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      home: SplashScreen(),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
    );
  }
}
