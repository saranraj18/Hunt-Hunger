import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackinutu/pages/AuthScreen.dart';
import 'package:hackinutu/styles/color.dart';
import 'dart:math';

import 'package:hackinutu/styles/text.dart';

class Fact extends StatefulWidget {
  @override
  _FactState createState() => _FactState();
}

class _FactState extends State<Fact> {
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
    List yourList = [
      'It\'s not how much we give but how much love we put into giving',
      'Let it snow; don’t let hunger grow.',
      'You can help beat hunger!Look what we can do together.',
      'We’re hungry for donations. Lend a hand, give a can.',
      'Sharing is caring',
      'Dude, let’s give some food. Food for thought — give a can today!',
      'Can you imagine a world without hunger? So help each other to fight against hunger!',
      'Give what you can. Take a bite out of hunger.',
    ];
    int randomIndex = Random().nextInt(yourList.length);
    return Scaffold(
      backgroundColor: indigo,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            yourList[randomIndex],
            style: sText.copyWith(fontSize: 17),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
