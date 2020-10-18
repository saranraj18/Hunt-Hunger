import 'package:flutter/material.dart';
import 'package:hackinutu/pages/Request.dart';
import 'package:hackinutu/pages/RequestPageDon.dart';
import 'package:hackinutu/styles/color.dart';

class BefReq extends StatefulWidget {
  BefReq({
    @required this.name,
    Key key,
  }) : super(key: key);

  final String name;
  @override
  _BefReqState createState() => _BefReqState();
}

class _BefReqState extends State<BefReq> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: indigo,
      appBar: AppBar(
        backgroundColor: indigo,
        elevation: 0,
        title: Text('Hello ${widget.name}'),
        bottom: TabBar(
          unselectedLabelColor: white,
          labelColor: pink,
          tabs: [
            Tab(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.1),
                decoration: BoxDecoration(
                    color: lightIndigo,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Request'),
              ),
            ),
            Tab(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.1),
                decoration: BoxDecoration(
                    color: lightIndigo,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Donations'),
              ),
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.transparent,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          Req(),
          ReqPageDon(),
        ],
        controller: _tabController,
      ),
    );
  }
}
