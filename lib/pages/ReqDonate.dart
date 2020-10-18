import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/pages/Donate.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';

class ReqDon extends StatefulWidget {
  @override
  _ReqDonState createState() => _ReqDonState();
}

class _ReqDonState extends State<ReqDon> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Request').snapshots(),
      builder: (context, snapshot) {
        final _doc = snapshot.data.documents;
        if (_doc == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: pink,
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
        } else if (_doc.length == 0) {
          return Center(
            child: Text(
              'No Requests as of now',
              style: sText.copyWith(fontSize: 23),
            ),
          );
        }
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
                  title: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      _doc[index]['name'],
                      style: sText,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          _doc[index]['mobile'],
                          style: sText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          _doc[index]['address'],
                          style: sText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'No. of persons available : ${_doc[index]['num']}',
                          style: sText,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Donate(
                              req: true, refId: _doc[index].reference.id),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
