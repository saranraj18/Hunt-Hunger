import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackinutu/pages/Login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;

  String name, email, password;
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Username should be atleast 4 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) => name = value.trim(),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                    ),
                    onChanged: (value) {
                      email = value.trim();
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password should be atleast 7 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        iconSize: 23,
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
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    child: Text('SignUp'),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        try {
                          auth
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((value) {
                            store.collection('users').doc(value.user.uid).set({
                              'name': name,
                              'email': email,
                            });
                          });
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                  InkWell(
                    child: Text('I already have an account'),
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
