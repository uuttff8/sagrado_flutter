import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key key}) : super(key: key);

  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Список', style: TextStyle(fontFamily: 'Circe')),
    1: Text('На карте', style: TextStyle(fontFamily: 'Circe')),
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
          "Площадки",
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
                  //color: Colors.lightGreenAccent,
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
      ),
    );
  }
}
