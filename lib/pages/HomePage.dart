import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/pages/Accept.dart';
import 'package:hackinutu/pages/BefDonate.dart';
import 'package:hackinutu/pages/Donate.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';
import 'package:hackinutu/services/global.dart' as global;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userName = 'User';

  Future _validCheck() async {
    var id;
    var docu;

    await _firestore
        .collection('Food List')
        .doc(global.pincode)
        .collection('Donations')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        var time = ds.get('Time').toDate();
        var diff = DateTime.now().difference(time).inMinutes;
        if (diff >= 180) {
          id = ds.get('uid');
          docu = ds.get('ref');
          print('Deleted ${ds.reference.id}');
          ds.reference.delete();
        }
      }
    });

    await _firestore
        .collection('Donation')
        .doc(id)
        .collection('List')
        .doc(docu)
        .update({'status': 'Deleted'});

    await Future.delayed(Duration(seconds: 2));
  }

  Future userDetails() async {
    String name = await _firestore
        .collection('users')
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) {
      global.name = value['name'];
      global.address = value['address'];
      global.mobile = value['mobile'];
      global.pincode = value['pincode'];
      return value['name'];
    });
    setState(() {
      userName = name;
    });
  }

  @override
  void initState() {
    userDetails();
    _validCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: indigo,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: width * 0.1),
              child: Center(
                child: Text(
                  'Welcome...',
                  style: tText,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Don(
                                name: userName,
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: lightIndigo,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    margin: EdgeInsets.only(
                      bottom: height * 0.1,
                      top: height * 0.1,
                      right: width * 0.01,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.09,
                      vertical: height * 0.1,
                    ),
                    child: Center(
                      child: Text(
                        'DONATE',
                        style: sText.copyWith(fontSize: 25),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Accept(
                          name: userName,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: lightIndigo,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    margin: EdgeInsets.only(
                      bottom: height * 0.1,
                      top: height * 0.1,
                      left: width * 0.01,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.09, vertical: height * 0.1),
                    child: Center(
                      child: Text(
                        'ACCEPT',
                        style: sText.copyWith(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
