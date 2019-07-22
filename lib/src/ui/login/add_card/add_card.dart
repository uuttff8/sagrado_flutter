export 'add_card_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sagrado_flutter/src/ui/login/chose.dart';
import 'add_card_provider.dart';

class AddCardScreen extends StatefulWidget {
  AddCardScreen({Key key, @required this.forMenu})
      : assert(forMenu != null),
        super(key: key);

  final bool forMenu;

  @override
  AddCardScreenState createState() => AddCardScreenState();
}

class AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameField = TextEditingController();
    TextEditingController cardNumberField = TextEditingController();

    String textHeader = !widget.forMenu
        ? 'Добавьте карту лояльности наших проектов. Если у Вас ещё нет карты Sagrado Loyalty, то просто нажмите "Далее"'
        : "Добавьте карту Sagrado Loyalty.";

    AddCardProvider provider = Provider.of<AddCardProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.only(left: 16, right: 16, top: 16.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  textHeader,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                AddCardTextField(
                  fioController: nameField,
                  text: 'ФИО',
                ),
                AddCardTextField(
                  fioController: cardNumberField,
                  text: 'Номер карты',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: PlatformButton(
                    child: Text('Далее'),
                    onPressed: () {
                      validate(provider);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Карта',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  void validate(AddCardProvider provider,
      {TextEditingController cardNumberField,
      TextEditingController nameField}) {
    provider.validate(
      context,
      number: cardNumberField?.text ?? "",
      name: (nameField?.text ?? ""),
      forMenu: widget.forMenu,
    );
  }
}

class AddCardTextField extends StatelessWidget {
  const AddCardTextField(
      {Key key, @required this.fioController, @required this.text})
      : super(key: key);

  final TextEditingController fioController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: fioController,
        decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
