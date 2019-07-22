import 'package:flutter/material.dart';
import 'package:sagrado_flutter/ui/login/add_card/add_card.dart';

class AddCardData {
  AddCardData({@required this.number, @required this.name});

  String number;
  String name;
}

class AddCardProvider with ChangeNotifier {
  AddCardProvider();

  var _data = AddCardData(name: "", number: "");
  AddCardScreenState _providerView = AddCardScreenState();

  void validate({String number, String name, bool forMenu}) {
    this._data = AddCardData(number: number, name: name);

    if (number.isNotEmpty && name.isNotEmpty) {
      onValidated();
    } else {
      if (forMenu) {
        throw Exception("Заполните все поля");
      } else {
        _providerView.onSkip();
      }
    }
  }

  void onValidated() {}
}
