import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  GoogleMapController mapController;

  @override
  void initState() {
    _currLoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 10.0),
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
      ),
    );
  }

  Future _currLoc() async {
    if (await GeolocatorPlatform.instance.isLocationServiceEnabled()) {
      await GeolocatorPlatform.instance
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          print('Yes');
          mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 13.0)));
        });
      });
    }
  }
}
