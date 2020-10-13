import 'package:flutter/material.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    this.color,
    this.text,
    this.onPressed,
    @required this.width,
    Key key,
  }) : super(key: key);

  final Color color;
  final String text;
  final Function onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.all(Radius.circular(width * 0.1)),
      color: color ?? pink,
      child: MaterialButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: width * 0.04),
          child: Text(
            text,
            style: sText.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
