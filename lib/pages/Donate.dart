import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/pages/DonateSuccess.dart';
import 'package:hackinutu/styles/Button.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';
import 'package:hackinutu/services/global.dart' as global;

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Widget> list = [];
  List<TextEditingController> control = [];
  int count = 0;

  int suff;

  final _formKey = GlobalKey<FormState>();

  _add() {
    final TextEditingController controller = TextEditingController();
    control.add(controller);
    setState(() {
      list = List.from(list)
        ..add(
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the details or remove';
              }
              if (!value.contains('-')) {
                return 'Enter the food item followed by \'-\' and then by quantity';
              }
              return null;
            },
            style: sText,
            decoration: InputDecoration(
              hintText: 'Items',
              hintStyle: sText,
              errorStyle: sText,
              errorBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: white)),
              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: white)),
              enabledBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: white)),
            ),
          ),
        );
      ++count;
    });
    print(count);
  }

  _rem() {
    setState(() {
      list.removeLast();
      control.removeLast();
      count--;
    });
  }

  Future _donate(List donList, List cont) async {
    Map q = {};

    for (var i = 0; i < donList.length; i++) {
      var a = cont[i].text.split('-');
      q[a[0].trimRight()] = a[1].trimLeft();
    }

    DateTime date = DateTime.now();
    String ref = date.millisecondsSinceEpoch.toString();

    await _firestore
        .collection('Food List')
        .doc(global.pincode)
        .collection('Donations')
        .doc()
        .set({
      'Item': q,
      'Time': date,
      'name': global.name,
      'address': global.address,
      'pincode': global.pincode,
      'mobile': global.mobile,
      'people': suff,
      'uid': _auth.currentUser.uid,
      'ref': ref,
    }).catchError((e) {
      print(e);
    });
    print(ref);
    await _firestore
        .collection('Donation')
        .doc(_auth.currentUser.uid)
        .collection('List')
        .doc(ref)
        .set({
      'Item': q,
      'Time': date,
      'uid': _auth.currentUser.uid,
      'status': 'Waiting',
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    control.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: indigo,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              count != 0
                  ? Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      color: lightIndigo.withOpacity(1),
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: list,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: white,
                                ),
                                onPressed: _rem,
                              ),
                            ),
                            TextFormField(
                              onChanged: (value) => suff = int.parse(value),
                              style: sText,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'No. of people',
                                hintStyle: sText,
                                errorStyle: sText,
                                errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.009,
                            ),
                            RoundButton(
                              width: width,
                              text: 'Donate',
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _donate(list, control).whenComplete(() {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext ctx) =>
                                            DonSuccess(),
                                      ),
                                    );
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: height * 0.01),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.1, vertical: height * 0.001),
                        child: Image.asset(
                          'images/donation.jpeg',
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
              Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: pink,
                        radius: 25,
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: _add,
                          iconSize: 27,
                        ),
                      ),
                      count < 2
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Please click this button to add the list',
                                style: sText,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
