import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecentsDon extends StatefulWidget {
  @override
  _RecentsDonState createState() => _RecentsDonState();
}

class _RecentsDonState extends State<RecentsDon> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('Donation')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('List')
          .get(),
      builder: (context, snapshot) {
        return Container();
      },
    );
  }
}
