import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

abstract class BaseScreen extends StatefulWidget {
  BaseScreen({Key key}) : super(key: key);

  void showErrorDialog(BuildContext context, {String title, String subtitle}) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text(title),
        content: Text(subtitle),
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
