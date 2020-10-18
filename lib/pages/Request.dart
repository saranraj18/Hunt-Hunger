import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/pages/BefRequest.dart';
import 'package:hackinutu/styles/Button.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';
import 'package:hackinutu/services/global.dart' as global;

class Req extends StatefulWidget {
  @override
  _ReqState createState() => _ReqState();
}

class _ReqState extends State<Req> {
  String persons;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: indigo,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 10,
              child: Text(
                'Request Food',
                style: tText,
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: sText,
                  keyboardType: TextInputType.number,
                  cursorColor: white,
                  decoration: InputDecoration(
                    hintText: 'No. of persons',
                    hintStyle: sText,
                    errorStyle: sText,
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: pink)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: white)),
                  ),
                  onChanged: (value) => persons = value.trim(),
                ),
              ),
            ),
            RoundButton(
              width: width,
              text: 'Request',
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Request')
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .set({
                  'name': global.name,
                  'num': persons,
                  'address': global.address,
                  'mobile': global.mobile,
                }).then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BefReq(
                        name: global.name,
                      ),
                    ),
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
