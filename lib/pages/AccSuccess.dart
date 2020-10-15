import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackinutu/pages/Accept.dart';
import 'package:hackinutu/pages/HomePage.dart';
import 'package:hackinutu/styles/Button.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';

class AccSuccess extends StatefulWidget {
  AccSuccess({
    this.map,
    Key key,
  }) : super(key: key);

  final Map map;

  @override
  _AccSuccessState createState() => _AccSuccessState();
}

class _AccSuccessState extends State<AccSuccess> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: indigo,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You\'ve successfully accepted the food',
                        style: sText,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: height * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Your list of food contains : ',
                        style: sText,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: lightIndigo,
                            borderRadius: BorderRadius.circular(30)),
                        margin: EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: widget.map.length,
                          itemBuilder: (_, index) {
                            String key = widget.map.keys.elementAt(index);
                            return ListTile(
                              title: Text(
                                "$key" + ': ' + "${widget.map[key]}",
                                style: sText.copyWith(fontSize: 17),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                  child: RoundButton(
                width: width,
                text: 'OK',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
