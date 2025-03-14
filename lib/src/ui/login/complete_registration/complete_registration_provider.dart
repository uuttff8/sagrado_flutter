import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sagrado_flutter/src/model/model.dart';
import 'package:sagrado_flutter/src/net/net_manager.dart';
import 'package:sagrado_flutter/src/services/user_manager.dart';

class RegistrationData {
  RegistrationData({
    @required this.name,
    @required this.lastname,
    @required this.birthDate,
    this.gender = 1,
  });

  // name and lastname for user
  String name, lastname;

  // birthday in format 'yyyy-MM-dd'
  DateTime birthDate;

  // gender where in case:
  //    male = 2
  //    female = 1
  int gender;
}

class CompleteRegistrationProvider with ChangeNotifier {
  var _data =
      RegistrationData(name: "", lastname: "", birthDate: null, gender: 2);

  bool onRegister(User user) {
    UserManager.saveUser(user);
    UserManager.setUserDoneRegistration(true);

    return true;
  }

  Future<bool> register() async {
    User user = await NetManager.shared.saveSettings(params: getParams());

    if (user.id != null) {
      return onRegister(user);
    }

    return false;
  }

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params;

    Map<String, bool> pushSettings = {
      "event": true,
      "news": true,
      "action": true,
    };

    Map<String, String> userMap = {
      "first_name": _getName(),
      "last_name": _getLastName(),
      "sex": _getGender(),
      "birth_date": _getBirthDate(),
    };

    Map<String, dynamic> profileMap = {
      "app": userMap,
    };

    params = {
      "profiles": profileMap,
      "push_subscribes": pushSettings,
      "push_token": "",
    };

    debugPrint(params.toString());

    return params;
  }

  void onGender({index: int}) {
    if (index == 0) {
      //male
      this._data.gender = 2;
    } else {
      //female
      this._data.gender = 1;
    }
  }

  void onBirthDate({date: DateTime}) {
    this._data.birthDate = date;
  }

  String _formatDate(DateTime date) {
    DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    return dateFormatter.format(date);
  }

  String _getName() {
    return this._data.name;
  }

  String _getLastName() {
    return this._data.lastname;
  }

  String _getBirthDate() {
    return this._formatDate(this._data.birthDate);
  }

  String _getGender() {
    return this._data.gender.toString();
  }

  bool _isNameValid() {
    return this._data.name.isNotEmpty;
  }

  bool _isLastNameValid() {
    return this._data.lastname.isNotEmpty;
  }

  // Even if initial date is DateTime.now()
  bool _isDateValid() {
    return this._data.birthDate != null;
  }

  bool checkFields({
    @required String name,
    @required String lastName,
    @required DateTime birthDate,
  }) {
    this._data = RegistrationData(
        name: name,
        lastname: lastName,
        birthDate: birthDate,
        gender: this._data.gender);

    bool isNameValid = this._isNameValid();
    bool isLastNameValid = this._isLastNameValid();
    bool isDateTimeValid = this._isDateValid();

    if (isNameValid && isLastNameValid && isDateTimeValid) {
      return true;
    } else {
      return false;
    }
  }
}
