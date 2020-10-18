import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';
import 'package:url_launcher/url_launcher.dart';

class ReqPageDon extends StatefulWidget {
  @override
  _ReqPageDonState createState() => _ReqPageDonState();
}

class _ReqPageDonState extends State<ReqPageDon> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String name, address, mobile, pincode;
  Map item;

  Future _det() async {
    await _firestore
        .collection('Request Donation')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      name = value['name'];
      mobile = value['mobile'];
      address = value['address'];
      pincode = value['pincode'];
      item = value['Item'];
    });
  }

  @override
  void initState() {
    _det();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    if (name == null) {
      return Center(
        child: Text(
          'No one has donated yet!',
          style: sText,
        ),
      );
    }
    return Container(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.005),
                child: Text(
                  name,
                  style: sText,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.005),
                child: Text(
                  mobile,
                  style: sText,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.005),
                child: Text(
                  address,
                  style: sText,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.005),
                child: Text(
                  pincode,
                  style: sText,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 7,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your list of food contains : ',
                    style: sText,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: lightIndigo,
                        borderRadius: BorderRadius.circular(30)),
                    margin: EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: item.length,
                      itemBuilder: (_, index) {
                        String key = item.keys.elementAt(index);
                        return ListTile(
                          title: Text(
                            "$key" + ': ' + "${item[key]}",
                            style: sText.copyWith(fontSize: 17),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future mapLaunch(String addr, String pinc) async {
    final String url =
        "https://www.google.com/maps/search/?api=1&query=$addr,$pinc";
    ;
    final String encodedURI = Uri.encodeFull(url);
    if (await canLaunch(encodedURI)) {
      await launch(encodedURI);
      print(addr);
    } else {
      print('Error launching Google Map');
    }
  }
}
