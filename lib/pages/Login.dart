import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackinutu/pages/SignUp.dart';
import 'package:hackinutu/styles/Button.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/dialog.dart';
import 'package:hackinutu/styles/text.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;

  final Dialogs dialog = Dialogs();

  String email, password;
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: indigo,
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.2),
                  child: Text(
                    'Log In',
                    style: tText,
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: pink,
                    style: sText,
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password should be atleast 7 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: sText,
                      errorStyle: sText,
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: pink)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white)),
                      suffixIcon: IconButton(
                        iconSize: 23,
                        color: white,
                        icon: hidePass
                            ? FaIcon(FontAwesomeIcons.eye)
                            : FaIcon(FontAwesomeIcons.eyeSlash),
                        onPressed: () {
                          setState(() {
                            hidePass = !hidePass;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      password = value.trim();
                    },
                    obscureText: hidePass ? true : false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(height * 0.02),
                  child: Text(
                    'Forgot Password?',
                    style: sText,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                RoundButton(
                  width: width,
                  text: 'Login',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState.validate()) {
                      try {
                        auth.signInWithEmailAndPassword(
                            email: email, password: password);
                      } catch (e) {
                        print(e);
                        var message =
                            'An error occured, please check your credentials!';
                        if (e.message != null) {
                          message = e.message;
                        }
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Oops!',
                                style: sText,
                              ),
                              content: Text(message),
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
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                InkWell(
                  child: Text(
                    'Create a new account?',
                    style: sText,
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
