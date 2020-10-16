import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hackinutu/pages/AuthScreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  completed() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Auth()));
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2500), completed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/logo.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
