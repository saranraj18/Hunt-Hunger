import 'package:flutter/material.dart';
import 'package:hackinutu/styles/color.dart';

const deco = InputDecoration(
  hintStyle: TextStyle(color: Colors.cyan),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(18),
    ),
    borderSide: BorderSide(
      color: dBlue,
      width: 2,
    ),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 15),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(18),
    ),
    borderSide: BorderSide(
      color: white,
      width: 2,
    ),
  ),
);
