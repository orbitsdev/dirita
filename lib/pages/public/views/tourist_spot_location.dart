





import 'dart:async';

import 'package:dirita_tourist_spot_app/pages/public/controller/geolocation_controller.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class TouristSpotLocation extends StatefulWidget {
  const TouristSpotLocation({ Key? key }) : super(key: key);

  @override
  _TouristSpotLocationState createState() => _TouristSpotLocationState();
}

class _TouristSpotLocationState extends State<TouristSpotLocation> {
   final Completer<GoogleMapController> _googleMapController =  Completer<GoogleMapController>();
   late GoogleMapController _newGoogleMapController;
  
   static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  late  Position currentPosition;
  var geolocator = Geolocator();


static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);



Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }


  void locationPosition(BuildContext context) async {
    Modal.showMediumProgressDialog(context: context,  );
    Position  position = await GeolocationController.determinePosition();
    Get.back();
    currentPosition = position;

    LatLng latLngPosition = LatLng(currentPosition.latitude , currentPosition.longitude);
    CameraPosition cameraposition = CameraPosition(target: latLngPosition,zoom: 16.999, tilt: 40, bearing: -1000);
    _newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: [
          GoogleMap(


            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.20, horizontal: 8.0,),
          
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _googleMapController.complete(controller);
            _newGoogleMapController = controller;
            locationPosition(context);
          },
        ),
        ],
      ),
     
    );
  
  }
}