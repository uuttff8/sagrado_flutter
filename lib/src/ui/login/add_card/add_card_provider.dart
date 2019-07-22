import 'package:flutter/material.dart';
import 'package:sagrado_flutter/src/ui/login/chose.dart';

class AddCardData {
  AddCardData({@required this.number, @required this.name});

  String number;
  String name;
}

class AddCardProvider with ChangeNotifier {
  AddCardProvider();

  var _data = AddCardData(name: "", number: "");

  void validate(BuildContext context,
      {@required String number,
      @required String name,
      @required bool forMenu}) {
    this._data = AddCardData(number: number, name: name);

    if (number.isNotEmpty && name.isNotEmpty) {
      onValidated();
    } else {
      if (forMenu) {
        throw Exception("Заполните все поля");
      } else {
        navigate(context, forMenu: forMenu);
      }
    }
  }

  void navigate(BuildContext context, {@required bool forMenu}) {
    if (!forMenu) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChoseScreen()),
      );
    } else {
      Navigator.pop(context);
    }
  }

  void onValidated() {}
}
