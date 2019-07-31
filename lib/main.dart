import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sagrado_flutter/src/ui/login/splash/splash_provider.dart';
import 'src/ui/login/splash/splash.dart';

void main() {
  runApp(SagradoApp());
}

class SagradoApp extends StatelessWidget {
  const SagradoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      home: ChangeNotifierProvider(
        builder: (context) => SplashProvider(context: context),
        child: SplashScreen(),
      ),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
    );
  }
}
