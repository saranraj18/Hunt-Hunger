import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/services/global.dart' as global;
import 'package:hackinutu/styles/Button.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';

class Accept extends StatefulWidget {
  Accept({
    @required this.name,
    Key key,
  }) : super(key: key);

  final String name;

  @override
  _AcceptState createState() => _AcceptState();
}

class _AcceptState extends State<Accept> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future _donGet() async {
    _firestore.collection('Food List').get().then((value) {
      // if
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: indigo,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: indigo,
          automaticallyImplyLeading: false,
          title: Text('Hello ${widget.name}'),
        ),
        body: Center(
          child: RoundButton(
            width: width,
            text: 'Test',
            onPressed: () async {
              await _firestore
                  .collection('Food List')
                  .where(FieldPath.documentId, isEqualTo: '603111')
                  .get()
                  .then((value) {
                // print(value.docs[index].get());
              });
            },
          ),
        ));
  }
}
