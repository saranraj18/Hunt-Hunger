import 'package:flutter/material.dart';
import 'package:hackinutu/styles/Button.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/styles/text.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccNext extends StatefulWidget {
  AccNext({
    this.address,
    this.map,
    this.mobile,
    this.name,
    this.pincode,
    this.time,
    Key key,
  }) : super(key: key);

  final String name;
  final String mobile;
  final String address;
  final String pincode;
  final Map map;
  final DateTime time;

  @override
  _AccNextState createState() => _AccNextState();
}

class _AccNextState extends State<AccNext> {
  add() {
    widget.map.forEach((key, value) {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: indigo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: indigo,
        title: Text(
          'Donation',
          style: sText,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.map.length,
        itemBuilder: (BuildContext context, int index) {
          String key = widget.map.keys.elementAt(index);
          return Column(
            children: <Widget>[
              index == 0
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            widget.name,
                            style: sText.copyWith(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(widget.mobile, style: sText),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(widget.address, style: sText),
                        ),
                      ],
                    )
                  : Container(),
              ListTile(
                title: Text(
                  "$key" + ': ' + "${widget.map[key]}",
                  style: sText.copyWith(fontSize: 17),
                ),
              ),
              index + 1 == widget.map.length
                  ? Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: RoundButton(
                        width: width,
                        text: 'Accept',
                      ),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
