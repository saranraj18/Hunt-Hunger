import 'package:flutter/material.dart';
import 'package:hackinutu/styles/color.dart';

void main() {
  runApp(Police());
}

class Police extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: dBlue,
          ),
          body: Container(color: lBlue)),
    );
  }
}
