import "dart:async";

import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});
  @override
  LocationState createState() {
    return LocationState();
  }
}

class LocationState extends State<LocationScreen> {
  String output = "";
// results go here:
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Future<void> getLocation() async {
    // 1. Chech if device has GPS enabled
    bool locationServicesEnabled = await Geolocator.isLocationServiceEnabled();
    if (locationServicesEnabled == false) {
      setState(() {
        output = ("ERROR: Permission denied.");
      });
    }

    // 2. Display a popup box that asks the use for locations
    LocationPermission permission = await Geolocator.checkPermission();

    // 3. Handle situations when permission is denied
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          output =
              ("ERROR: Permission denied this time. Will ask again next time.");
        });
      }
    }
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        output = ("ERROR: Permission permanently denied. Cannot proceed.");
      });
    }

    Position currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      output =
          "Your location is: ${currentPosition.latitude}, ${currentPosition.longitude}";
      // latitude = currentPosition.latitude;
      // longitude = currentPosition.longitude;
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }
}
