import 'package:flutter/material.dart';
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
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: pink,
              ),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.data.documents.length == 0) {
            return Center(
              child: Text(
                'Sorry, there are no donations as of now for this location',
                style: sText,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
