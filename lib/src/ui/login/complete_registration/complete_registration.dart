import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sagrado_flutter/src/ui/login/add_card/add_card.dart';
import 'package:sagrado_flutter/src/ui/login/complete_registration/complete_registration_provider.dart';

class CompleteRegistration extends StatefulWidget {
  CompleteRegistration({Key key}) : super(key: key);

  @override
  CompleteRegistrationState createState() => CompleteRegistrationState();
}

class CompleteRegistrationState extends State<CompleteRegistration> {
  DateTime date = DateTime.now();
  int sharedValue = 0;
  final Map<int, Widget> logoWidgets = {
    0: Text('Мужской'),
    1: Text('Женский'),
  };

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CompleteRegistrationProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          actions: <Widget>[
            drawNextButton(provider),
          ],
        ),
        body: SafeArea(
          minimum: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                RegistrationTitle(),
                NameTextField(hintText: "Имя", controller: nameController),
                SizedBox(height: 15),
                NameTextField(
                    hintText: "Фамилия", controller: lastNameController),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Text('Пол'),
                    SizedBox(
                      width: 200,
                      child: CupertinoSegmentedControl<int>(
                        children: logoWidgets,
                        onValueChanged: (val) {
                          setState(() {
                            sharedValue = val;
                            provider.onGender(index: val);
                          });
                        },
                        groupValue: sharedValue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text('Дата рождения'),
                    SizedBox(width: 15),
                    Text('${DateFormat('yyyy-MM-dd').format(date)}')
                  ],
                ),
                SizedBox(height: 15),
                MaterialButton(
                  child: Text(
                    "Выберите дату рождения",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height / 3,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newdate) {
                              setState(() {
                                date = newdate;
                              });
                            },
                            use24hFormat: true,
                            maximumDate: new DateTime(2020, 12, 30),
                            minimumYear: 1960,
                            maximumYear: 2019,
                            minuteInterval: 1,
                            mode: CupertinoDatePickerMode.date,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawNextButton(CompleteRegistrationProvider provider) => Container(
        alignment: Alignment.topRight,
        child: PlatformWidget(
          ios: (context) {
            return CupertinoButton(
              child: Text(
                'Далее',
                style: TextStyle(color: CupertinoColors.activeBlue),
              ),
              onPressed: () {
                platformCheckFields(provider);
              },
            );
          },
          android: (context) {
            return FlatButton(
              child: Text(
                'Далее',
                style: TextStyle(color: Colors.blue, fontSize: 17),
              ),
              onPressed: () {
                platformCheckFields(provider);
              },
            );
          },
        ),
      );

  void platformCheckFields(CompleteRegistrationProvider provider) async {
    bool isCheck = provider.checkFields(
      name: nameController.text,
      lastName: lastNameController.text,
      birthDate: date,
    );

    if (isCheck == true) {
      provider.register().then((bool v) {
        if (v) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  builder: (_) => AddCardProvider(),
                  child: AddCardScreen(forMenu: false)),
            ),
          );
        }
      });
    } else {
      _showErrorDialog(context, title: "Заполните все поля");
    }
  }

  void _showErrorDialog(BuildContext context, {String title}) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text(title),
        //content: Text(subtitle),
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

class RegistrationTitle extends StatelessWidget {
  const RegistrationTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        'Регистрация',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({
    Key key,
    this.hintText,
    @required this.controller,
  }) : super(key: key);

  final String hintText;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      autocorrect: false,
    );
  }
}
