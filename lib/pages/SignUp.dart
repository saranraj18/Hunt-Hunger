import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackinutu/pages/HomePage.dart';
import 'package:hackinutu/styles/Button.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;

  String name, email, password, confirmPassword, mobile, address, pincode;
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
                  padding: EdgeInsets.only(top: height * 0.15),
                  child: Text(
                    'Sign Up',
                    style: tText,
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: sText,
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Username should be atleast 4 characters';
                      }
                      return null;
                    },
                    cursorColor: white,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: sText,
                      errorStyle: sText,
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: pink)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white)),
                    ),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) => name = value.trim(),
                  ),
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
                    ),
                    onChanged: (value) {
                      password = value.trim();
                    },
                    obscureText: hidePass ? true : false,
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
                      hintText: 'Confirm Password',
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
                      confirmPassword = value.trim();
                    },
                    obscureText: hidePass ? true : false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: sText,
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Username should be atleast 4 characters';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    cursorColor: white,
                    decoration: InputDecoration(
                      hintText: 'Mobile No.',
                      hintStyle: sText,
                      errorStyle: sText,
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: pink)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white)),
                    ),
                    onChanged: (value) => mobile = value.trim(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: sText,
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Username should be atleast 4 characters';
                      }
                      return null;
                    },
                    maxLines: 2,
                    cursorColor: white,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      hintStyle: sText,
                      errorStyle: sText,
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: pink)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white)),
                    ),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) => address = value.trim(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: sText,
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Username should be atleast 4 characters';
                      }
                      return null;
                    },
                    cursorColor: white,
                    decoration: InputDecoration(
                      hintText: 'Pincode',
                      hintStyle: sText,
                      errorStyle: sText,
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: pink)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white)),
                    ),
                    onChanged: (value) => pincode = value.trim(),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                RoundButton(
                  width: width,
                  text: 'SignUp',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (password == confirmPassword) {
                      if (_formKey.currentState.validate()) {
                        try {
                          auth
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((value) {
                            store.collection('users').doc(value.user.uid).set({
                              'name': name,
                              'email': email,
                              'mobile': mobile,
                              'address': address,
                              'pincode': pincode,
                            });
                          });
                        } catch (e) {
                          print(e);
                        }
                      }
                    } else {
                      print('Password doesn\'t match');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
