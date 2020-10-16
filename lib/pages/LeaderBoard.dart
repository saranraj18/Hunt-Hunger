import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';

class LBoard extends StatefulWidget {
  @override
  _LBoardState createState() => _LBoardState();
}

class _LBoardState extends State<LBoard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: indigo,
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: indigo,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Leaderboard',
          style: sText,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('LeaderBoard')
            .orderBy('count', descending: true)
            .get(),
        builder: (_, snapshot) {
          final docum = snapshot.data.documents;
          if (docum == null || snapshot.hasError) {
            print(snapshot.error);
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: pink,
              ),
            );
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name',
                      style: sText.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      width: width * 0.2,
                    ),
                    Text(
                      'Donations',
                      style: sText.copyWith(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: docum.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Container(
                            color: index == 0
                                ? Colors.amber[800]
                                : index == 1
                                    ? Colors.grey[400]
                                    : index == 2
                                        ? Colors.deepOrangeAccent[400]
                                        : lightIndigo,
                            margin: EdgeInsets.symmetric(
                                vertical: height * 0.002,
                                horizontal: width * 0.1),
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.01),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    docum[index]['name'],
                                    style: sText.copyWith(
                                        fontSize: 17,
                                        color:
                                            index <= 2 ? Colors.black : null),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        (int.parse('${docum[index]['count']}') -
                                                1)
                                            .toString(),
                                        style: sText.copyWith(
                                            fontSize: 17,
                                            color: index <= 2
                                                ? Colors.black
                                                : null),
                                      ),
                                      index <= 2
                                          ? FaIcon(FontAwesomeIcons.medal)
                                          : Container()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          index == 2
                              ? SizedBox(
                                  height: height * 0.025,
                                )
                              : Container(),
                          index == 12
                              ? SizedBox(
                                  height: height * 0.025,
                                )
                              : Container(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
