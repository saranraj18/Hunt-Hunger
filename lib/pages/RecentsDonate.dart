import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';
import 'package:url_launcher/url_launcher.dart';

class RecentsDon extends StatefulWidget {
  @override
  _RecentsDonState createState() => _RecentsDonState();
}

class _RecentsDonState extends State<RecentsDon> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('Donation')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('List')
          .get(),
      builder: (context, snapshot) {
        final _doc = snapshot.data.documents;
        if (_doc == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: pink,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: Text('No data'),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
        } else {
          return ListView.builder(
            itemCount: _doc.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: pink,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  color: lightIndigo,
                  child: ListTile(
                    title: _doc[index]['status'] == 'Accepted'
                        ? Text(_doc[index]['name'], style: sText)
                        : _doc[index]['status'] == 'Deleted'
                            ? Text('Deleted', style: sText)
                            : Text('Waiting', style: sText),
                    subtitle: _doc[index]['status'] == 'Accepted'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: Text(
                                  _doc[index]['mobile'],
                                  style: sText,
                                ),
                                onTap: () =>
                                    launch("tel:${_doc[index]['mobile']}"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.005),
                                child:
                                    Text(_doc[index]['address'], style: sText),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.005),
                                child: Text(
                                    _doc[index]['Time'].toDate().toString(),
                                    style: sText),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.005),
                                child: Text(
                                    _doc[index]['Time'].toDate().toString(),
                                    style: sText),
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: indigo,
      body: SafeArea(
        child: ListView.builder(itemBuilder: null),
      ),
    );
  }
}
