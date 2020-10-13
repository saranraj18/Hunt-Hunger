import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/pages/DonateSuccess.dart';
import 'package:hackinutu/pages/Login.dart';
import 'package:hackinutu/styles/Button.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';

class Donate extends StatefulWidget {
  Donate({
    @required this.name,
    Key key,
  }) : super(key: key);

  final String name;

  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Widget> list = [];
  List<TextEditingController> control = [];
  int count = 0;

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

  @override
  void dispose() {
    control.clear();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: indigo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: indigo,
        title: Text('Hello ${widget.name}'),
      ),
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
                            RoundButton(
                              width: width,
                              text: 'Donate',
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  for (var i = 0; i < list.length; i++) {
                                    var a = control[i].text.split('-');
                                    print(a[0].trimRight());
                                    print(a[1].trimLeft());
                                    _firestore
                                        .collection('Food List')
                                        .doc(_auth.currentUser.uid)
                                        .collection('donations')
                                        .add({
                                      a[0].trimRight(): a[1].trimLeft(),
                                    }).then((value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DonSuccess(),
                                        ),
                                      );
                                    }).catchError((e) {
                                      print(e);
                                    });
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                _auth.signOut();
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
