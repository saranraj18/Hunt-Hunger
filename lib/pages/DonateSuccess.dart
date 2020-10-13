import 'package:flutter/material.dart';
import 'package:hackinutu/pages/Donate.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';

class DonSuccess extends StatefulWidget {
  @override
  _DonSuccessState createState() => _DonSuccessState();
}

class _DonSuccessState extends State<DonSuccess> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You\'ve successfully donated...',
              style: sText,
            ),
            FlatButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Donate(
                    name: 'Saran',
                  ),
                ),
              ),
              child: Text(
                'Back to Navigation',
                style: sText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
