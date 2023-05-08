



import 'dart:async';

import 'package:dirita_tourist_spot_app/models/geo_model.dart';
import 'package:dirita_tourist_spot_app/models/place_details.dart';
import 'package:dirita_tourist_spot_app/pages/admin/controllers/location_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/controller/geolocation_controller.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({ Key? key }) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  

  final Completer<GoogleMapController> _googleMapController =  Completer<GoogleMapController>();
  final locationController = Get.find<LocationController>();
   late GoogleMapController _newGoogleMapController;



   Set<Marker> markerSet = {};
   Set<Circle> circleSet = {};
   Marker? selectedMarker;
   Circle? selectedCircle;
   bool isShow =true;
  late PlaceDetails selectedLocation;

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

    setDetails(latLngPosition);
  }


  void setDetails(LatLng latling) async {
      selectedLocation  = await  locationController.getCurrentLocationDetails(latling);
      
  } 


  void setShow(bool value ){
      setState(() {
        isShow = value;

      });
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(

            fit: StackFit.expand,
        children: [
          GoogleMap(
          
            padding:   EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.33,
              right: 8.0,
              left: 8.0,
              top: MediaQuery.of(context).size.height * 0.05,
            ),
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
            bottom: 16,
            right: 14,
            left: 14,
            child:isShow ? Container(
              decoration: BoxDecoration(
                   color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
             constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.20,
             ),
           
              child: SingleChildScrollView(
                child: Column(
                  children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   height: 34,
                          //   width: 34,
                          //   child: IconButton(style:ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade100), onPressed: (){}, icon: Center(child: Icon(Icons.arrow_back_ios_new,size:  16,  color: Colors.grey.shade600,)))),
                          
                          Text('Current Location', style: TextStyle(),),
                          SizedBox(
                            height: 34,
                            width: 34,
                            child: IconButton(
                              style:ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade100), onPressed: ()=>setShow(false), 
                              icon: Center(child: Icon(Icons.close,size:  20,  color: Colors.grey.shade600,
                              ),
                              ),
                              ),
                              ),
                          
                        ],
                      ),
                      Divider(
                          color: Colors.grey.shade200,
                          ),
                        Column(
                          children: [
                                                  VSpace(10),
                            GetBuilder<LocationController>(
                              builder: (controller) {
                                return  controller.isLoading.value ? Center(child: LoaderWidget() ,):  Text('${controller.currentLocationDetails.value.formatted_address ?? ''}' , style: TextStyle(color: Colors.grey.shade700), );
                              }
                            )
                          ],
                        ),
                  ],
                ),
              ),
              
            ).animate().scale(duration: Duration(milliseconds: 400), curve: Curves.easeInOut) : Container(child:  IconButton(
                              style:ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300), onPressed: ()=>setShow(true), 
                              icon: Center(child: Icon(Icons.arrow_upward,size:  20,  color: Colors.grey.shade600,
                              ),
                              ),
                              ),) ,
          ),
        ],
      ));
  }
}