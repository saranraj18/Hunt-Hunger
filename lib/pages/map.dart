import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackinutu/styles/color.dart';
import 'package:hackinutu/services/global.dart' as global;

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  GoogleMapController mapController;

  List<Marker> allMarker = [];

  Widget loadPage() {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('Markers').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: indigo,
            ),
          );
        }
        for (int i = 0; i < snapshot.data.docs.length; i++) {
          print(snapshot.data.docs[i].reference.id);
          allMarker.add(
            Marker(
              markerId: MarkerId(snapshot.data.docs[i].reference.id),
              position: LatLng(snapshot.data.docs[i]['coords'].latitude,
                  snapshot.data.docs[i]['coords'].longitude),
              draggable: false,
              // infoWindow: InfoWindow(
              //     title: snapshot.data.docs[i]['name'],
              //     snippet: snapshot.data.docs[i]['address'])
            ),
          );
        }
        return GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(global.lat, global.long), zoom: 10.0),
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          markers: Set.from(allMarker),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: indigo,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.05),
            child: loadPage(),
          ),
          Positioned(
            bottom: 20,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
