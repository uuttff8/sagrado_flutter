import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:sagrado_flutter/net/net_manager.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

import 'package:sagrado_flutter/ui/login/chose.dart';
import 'package:sagrado_flutter/ui/login/complete_registration.dart';

class CodeScreen extends StatefulWidget {
  CodeScreen({Key key, @required this.phone, @required this.isNew}) : super(key: key);

  final bool isNew;
  final String phone;

  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CodeTextField codeTextField = CodeTextField(controller: controller);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        child: PlatformScaffold(
          appBar: PlatformAppBar(
            backgroundColor: Color(0xFF192d37),
            ios: (context) {
              return CupertinoNavigationBarData(
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(CupertinoIcons.forward),
                  onPressed: () async {
                    try {
                      var response = await NetManager.shared.codeConfirmPhone(
                        phone: widget.phone,
                        code: codeTextField.controller.text,
                      );

                      if (response.error == true) {
                        badCodeForm(context);
                        return;
                      }
                      
                      print(widget.phone +
                          '  cc   ' +
                          codeTextField.controller.text);

                      FlutterKeychain.put(key: 'token', value: response.token ?? ''); // i'm not sure, but...

                      if (widget.isNew == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CompleteRegistration()),
                        );
                      } else {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChoseScreen()),
                      );
                      }
                      
                    } catch (e) {
                      print('done: $e');
                    }
                  },
                ),
                leading: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(CupertinoIcons.back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF192d37),
                  Color(0xFF1e1f24),
                ],
              ),
            ),
            child: SafeArea(
              minimum: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'ВВЕДИТЕ КОД ПОДТВЕРЖДЕНИЯ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Код подтверждения был выслан на указанный вами телефон',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 100),
                  CodeTextField(
                    controller: controller,
                  ),
                  SizedBox(height: 20),
                  PlatformButton(
                    child: Text(
                      'Выслать код повторно',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void badCodeForm(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text('Код'),
        content: Text('Введите правильный код'),
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

class CodeTextField extends StatelessWidget {
  const CodeTextField({Key key, @required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Enter the code from SMS',
        hintStyle: TextStyle(color: Colors.white),
        disabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      showCursor: true,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
    );
  }
}

//flutter: {"status":"success","token":"sPG4fv2cGe5DUA9gkDrzHrCqIj6wQOqwrOxOw5G6L8yaeN4y15",
//"push_token":"","os_type":"","user_id":256,"user":{"id":256,"username":"79773142793",
//"email":null,"created_at":"2019-07-02 00:10:04","updated_at":"2019-07-02 00:10:04",
//"logined_at":null,"avatar":null,"push_subscribes":{"event":false,"news":false,"action":false},
//"email_subscribe":0,"admin":0,"user_devices":[]}}
