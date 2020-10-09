import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/loginPage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "You are Logged in succesfully",
              style: TextStyle(color: Colors.lightBlue, fontSize: 32),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "${FirebaseAuth.instance.currentUser.phoneNumber}",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            FlatButton(
              child: Text('Logout'),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
