import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/pages/AcceptNext.dart';
import 'package:hackinutu/services/global.dart' as global;
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

  bool there = true;

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
      body: there
          ? FutureBuilder(
              future: _firestore
                  .collection('Food List')
                  .doc(global.pincode)
                  .collection('Donations')
                  .get(),
              builder: (_, snapshot) {
                final documents = snapshot.data.documents;
                if (documents == null) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: pink,
                    ),
                  );
                }
                if (documents.length == 0) {
                  return Center(
                    child: Text('We are sorry'),
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: pink,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 5,
                        color: lightIndigo,
                        child: ListTile(
                          onTap: () {},
                          title: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.005),
                            child: Text(
                              documents[index]['name'],
                              style: sText,
                            ),
                          ),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.005),
                                child: Text(
                                  documents[index]['mobile'],
                                  style: sText,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.005),
                                child: Text(
                                  documents[index]['address'],
                                  style: sText,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.005),
                                child: Text(
                                  'No. of persons(Approx.) : ${documents[index]['people'].toString()}',
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AccNext(
                                      address: documents[index]['address'],
                                      map: documents[index]['Item'],
                                      mobile: documents[index]['mobile'],
                                      name: documents[index]['name'],
                                      pincode: documents[index]['pincode'],
                                      id: documents[index].reference.id,
                                      time: documents[index]['Time'].toDate(),
                                      uid: documents[index]['uid'],
                                      docu: documents[index]['ref'],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : Center(
              child: Text('Sorry'),
            ),
    );
  }
}
