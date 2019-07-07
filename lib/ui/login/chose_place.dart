import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:flutter/foundation.dart';

class ChosePlaceScreen extends StatelessWidget {
  const ChosePlaceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: FlatButton(
          onPressed: () {},
          child: Text(
            'Выбрать все',
            style:
                TextStyle(color: Colors.black, fontSize: 17, letterSpacing: 1),
          ),
        ),
        trailingActions: <Widget>[
          FlatButton(
            child: Container(
              //dont work as expected: icon just alignment by center
              // TODO(uuttff8): alignment icon by end
              alignment: Alignment.centerRight,
              child: Icon(
                CupertinoIcons.right_chevron,
                color: Colors.black,
              ),
            ),
            onPressed: () {
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Container(
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 3000,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
