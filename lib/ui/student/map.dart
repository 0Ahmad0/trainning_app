import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'company_offer.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  // Position? position;
  //GoogleMapController? mapController;
  Position? position;
  Set<Marker> markers = {};

  @override
  late GoogleMapController mapController;
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    getLocations();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    // location.Location _location = new location.Location();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      serviceEnabled = await Geolocator.openAppSettings();
      if (!serviceEnabled) {
        return Future.error(
            "AppLocalizations.of(context)!.locationServicesAreDisabled");
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(
            "AppLocalizations.of(context)!.locationPermissionsAreDenied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error("AppLocalizations.of(context)!");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
    });
  }

  void getLocations() async {
    await FirebaseFirestore.instance
        .collection("companyRequests")
        .get()
        .then((value) {
      for (var i in value.docs) {
        markers.add(
          Marker(
              markerId: MarkerId(i.id),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueMagenta),
              position: LatLng(i.data()["latitude"], i.data()["longitude"]),
              // infoWindow: InfoWindow(title: location.data()["name"]),
              onTap: () {
                print(i.data()['id']);
                print("object");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CompanyOffer(
                      companyRequest: i.data()['id'],
                    ),
                  ),
                );
              }),
        );
      }
      print(markers.length);
    });
/*
    final snapshot =
        await FirebaseFirestore.instance.collection("locations").get();

    for (var location in snapshot.docs) {
      markers.add(
        Marker(
          markerId: MarkerId(location.id),
          position:
              LatLng(location.data()["latitude"], location.data()["longitude"]),
          // infoWindow: InfoWindow(title: location.data()["name"]),
        ),
      );
    }*/
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.terrain,
              markers: markers,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentPosition!.latitude, currentPosition!.longitude),
                zoom: 14.0,
              ),
            ),
    );
  }
}
