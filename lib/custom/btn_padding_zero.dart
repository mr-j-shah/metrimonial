import 'package:flutter/material.dart';

class ButtonPaddingZero extends StatelessWidget {
  Function onPressed;
  final text;
  ButtonPaddingZero({
    Key key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: onPressed,
      child: text,
    );
  }
}
