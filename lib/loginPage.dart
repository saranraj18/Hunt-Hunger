import 'package:flutter/material.dart';
import 'package:hackinutu/OTP.dart';
import 'package:hackinutu/styles/textformfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Column(
          children: [
            TextField(
              decoration: form.copyWith(hintText: 'Phone Number'),
              onChanged: (value) => _phone = value,
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OTP(_phone),
                ),
              ),
              child: Text('Submit'),
            )
          ],
        ));
  }
}
