import 'package:flutter/material.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';

class Dialogs {
  error(context, text) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: lightIndigo,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Oops!',
            style: sText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text ?? 'Something went wrong!!! Please try again',
                  style: sText,
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Ok',
                style: sText,
              ),
            ),
          ],
        );
      },
    );
  }

  info(context, title, text, function) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: lightIndigo,
      builder: (context) {
        return AlertDialog(
          title: title ?? 'Confirmation',
          titleTextStyle: sText.copyWith(
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: sText,
          content: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text ?? 'Are you sure?'),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'No',
                style: sText,
              ),
            ),
            FlatButton(
              onPressed: () => function,
              child: Text(
                'Yes',
                style: sText,
              ),
            ),
          ],
        );
      },
    );
  }
}
