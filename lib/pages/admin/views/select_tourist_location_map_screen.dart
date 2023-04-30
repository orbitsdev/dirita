import 'dart:async';

import 'package:dirita_tourist_spot_app/delegates/location_search_delegate.dart';
import 'package:dirita_tourist_spot_app/pages/public/controller/geolocation_controller.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/rounded_card_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../../../utils/app_theme.dart';

class SelectTouristLocationSpotScreen extends StatefulWidget {
  const SelectTouristLocationSpotScreen({Key? key}) : super(key: key);

  @override
  _SelectTouristLocationSpotScreenState createState() =>
      _SelectTouristLocationSpotScreenState();
}

class _SelectTouristLocationSpotScreenState extends State<SelectTouristLocationSpotScreen> {
  final Completer<GoogleMapController> _googleMapController =  Completer<GoogleMapController>();
  late GoogleMapController _newGoogleMapController;

   Set<Marker> markerSet = {};
   Set<Circle> circleSet = {};
   Marker? selectedMarker;
   Circle? selectedCircle;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late Position currentPosition;
  var geolocator = Geolocator();

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  void locationPosition(BuildContext context) async {
    Modal.showMediumProgressDialog(
      context: context,
    );
    Position position = await GeolocationController.determinePosition();
    Get.back();
    currentPosition = position;

    LatLng latLngPosition =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    CameraPosition cameraposition = CameraPosition(
        target: latLngPosition, zoom: 16.999, tilt: 40, bearing: -1000);
    _newGoogleMapController .animateCamera(CameraUpdate.newCameraPosition(cameraposition));
  }

  void setLocation(LatLng latlng){ 
    
    setMarker(latlng);
    setCircle(latlng);
    moveCamera(latlng);

  }

  void moveCamera(LatLng latlng){
 CameraPosition cameraposition = CameraPosition( target: latlng, zoom: 16.999, bearing: -1000);
    _newGoogleMapController .animateCamera(CameraUpdate.newCameraPosition(cameraposition));
  }

  void setMarker(LatLng latlng){
       selectedMarker = Marker(
      
      markerId: MarkerId('selectedMarker'),
      position: latlng,
       
    );
    setState(() {
      markerSet.add(selectedMarker as Marker);
    });
  }
  
  void setCircle(LatLng latlng){
    selectedCircle = Circle(
      zIndex: 1,
        fillColor: Colors.orange.withOpacity(0.8),
        strokeWidth: 1,
        radius: 12,
        center: latlng,
        strokeColor: Colors.orange.withOpacity(0.10),
        circleId: CircleId("pickcicrcle"));

 setState(() {
      circleSet.add(selectedCircle as Circle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Location'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(result: null),
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: LocationSearchDelegate()),
              icon: Icon(Icons.search)),
          const HSpace(10),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [

          
        
          GoogleMap(

            onTap: (location) => setLocation(location),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.30,
              right: 8.0,
              left: 8.0,
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            markers: markerSet,
            circles: circleSet,
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
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: RoundedCardWidget(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Tap map to select location',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          VSpace(10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 0.4,
                                  color: Colors.grey,
                                )),
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text('No location was selected  at this  moment  '),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  VSpace(10),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: AppTheme.ORANGE,
                        primary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Confirm".toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
