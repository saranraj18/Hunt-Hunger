import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hackinutu/pages/AuthScreen.dart';
import 'package:hackinutu/pages/facts.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  completed() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Fact()));
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), completed);
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
