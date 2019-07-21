import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({Key key, @required this.forMenu})
      : assert(forMenu != null),
        super(key: key);

  final bool forMenu;
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        color: Colors.black,
      ),
    );
  }
}
