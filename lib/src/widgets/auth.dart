import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final MaskedTextController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(primaryColor: Colors.white),

        child: TextField(
          textAlign: TextAlign.center,
          controller: controller,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '+7(XXX)-XXX-XX-XX',
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
    );
  }
}

class Drawhorizontalline extends CustomPainter {
  Paint _paint;

  Drawhorizontalline() {
    _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(-90.0, 0.0), Offset(90.0, 0.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton(this.title,
      {Key key, this.color = Colors.white70, this.isShadow, this.onPressed})
      : super(key: key);

  final bool isShadow;
  final Text title;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var shadowAtButton = BoxShadow(
      color: Colors.black38,
      blurRadius: 20.0,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [if (isShadow == true) shadowAtButton],
          ),
          child: RaisedButton(
            child: title,
            color: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
