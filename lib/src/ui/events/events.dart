import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Избранные площадки', style: TextStyle(fontFamily: 'Circe')),
    1: Text('Все площадки', style: TextStyle(fontFamily: 'Circe')),
  };

  int sharedValue = 0;

  Widget onChangeScreen(int screen) {
    switch (screen) {
      case 0:
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blueAccent,
        );
        break;
      case 1:
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
        );
        break;
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: onChangeScreen(sharedValue),
      appBar: AppBar(
        title: Text(
          "События",
          style: TextStyle(
            fontFamily: 'Circe',
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  child: CupertinoSegmentedControl(
                      selectedColor: Colors.black,
                      borderColor: Colors.black,
                      pressedColor: Colors.black26,
                      children: this.logoWidgets,
                      groupValue: this.sharedValue,
                      onValueChanged: (value) {
                        this.setState(() {
                          this.sharedValue = value;
                        });
                      }),
                ),
              )
            ],
          ),
          preferredSize: Size(double.infinity, 30),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          PlatformButton(
            child: Text(
              'Календарь',
              style: TextStyle(
                  fontFamily: 'Circe', color: CupertinoColors.activeBlue),
            ),
            onPressed: () {
              print('Calendar button pressed');
            },
            ios: (_) => CupertinoButtonData(padding: EdgeInsets.zero),
          )
        ],
      ),
    );
  }
}
