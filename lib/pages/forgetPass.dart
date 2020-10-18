import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/pages/Login.dart';
import 'package:hackinutu/styles/Button.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';

class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  String email;

  Future _resetPass() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
            (route) => false);
      });
    } catch (e) {
      var message = 'An error occured! Please check your credentials';
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: indigo,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                child: Text(
                  'Forget Password',
                  style: tText.copyWith(fontSize: width * 0.1),
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Enter your registered email address', style: sText),
                    SizedBox(height: height * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        style: sText,
                        cursorColor: pink,
                        decoration: InputDecoration(
                          fillColor: white,
                          hintText: 'Email Address',
                          errorStyle: sText,
                          hintStyle: sText,
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: pink)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: white)),
                        ),
                        onChanged: (value) {
                          email = value.trim();
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    RoundButton(
                      width: width,
                      text: 'Submit',
                      onPressed: () {
                        _resetPass();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
