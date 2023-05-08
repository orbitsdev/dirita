import 'dart:async';

import 'package:dirita_tourist_spot_app/ai/text_to_speech_controller.dart';
import 'package:dirita_tourist_spot_app/ai/voice_data.dart';
import 'package:dirita_tourist_spot_app/localdatabase/shared_preference_manager.dart';
import 'package:dirita_tourist_spot_app/models/Direction.dart' as d;
import 'package:dirita_tourist_spot_app/pages/admin/controllers/location_controller.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/public/controller/geolocation_controller.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';

class TouristSpotLocation extends StatefulWidget {
  TouristSpot? touristspot;
  TouristSpotLocation({
    Key? key,
    this.touristspot,
  }) : super(key: key);

  @override
  _TouristSpotLocationState createState() => _TouristSpotLocationState();
}

class _TouristSpotLocationState extends State<TouristSpotLocation> {
  var locationController = Get.find<LocationController>();
  final Completer<GoogleMapController> _googleMapController =
      Completer<GoogleMapController>();
  late GoogleMapController _newGoogleMapController;

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};
  Set<Polyline> polylineSet = {};
  Marker? selectedMarker;
  Circle? selectedCircle;

  bool isShow = false;



  d.Direction? direction;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late Position currentPosition;
  LatLng? device_position;
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

    device_position =
        LatLng(currentPosition.latitude, currentPosition.longitude);

    CameraPosition cameraposition = CameraPosition(
        target: device_position as LatLng,
        zoom: 16.999,
        tilt: 40,
        bearing: -1000);
    _newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraposition));

    setInitialMarker();
  }

  void setLocation(LatLng latlng) {
    setMarker(latlng);
    setCircle(latlng);
    moveCamera(latlng);
  }

  void clearMap() {
    setState(() {
      markerSet.clear();
      circleSet.clear();
    });
  }

  void moveCamera(LatLng latlng) {
    CameraPosition cameraposition =
        CameraPosition(target: latlng, zoom: 16.999, bearing: -1000);
    _newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraposition));
  }

  void setMarker(LatLng latlng) {
    selectedMarker = Marker(
      markerId: MarkerId('selectedMarker'),
      position: latlng,
    );
    setState(() {
      markerSet.add(selectedMarker as Marker);
    });
  }

  void setCircle(LatLng latlng) {
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

  void setInitialMarker() {
    if (widget.touristspot!.place_id != null) {
      LatLng latLng = LatLng(widget.touristspot!.latitude as double,
          widget.touristspot!.longtitude as double);
      setLocation(latLng);
    }
  }

  void getDirection(BuildContext context) async {
       
         final enabled = await SharedPreferencesManager.getEnableRouteVoice();
       
         if(enabled){
              TextToSpeechController.speak(VoiceAiSpeech.generating);
         }
  
    final result = await locationController.getDirection(
        context: context,
        destination: LatLng(widget.touristspot!.latitude as double,
            widget.touristspot!.longtitude as double));

    if (result != null) {
      setDirection(result);
    }
  }

  void setDirection(d.Direction newdirection) async {
    setState(() {
      direction = newdirection;

      polylineSet.add(
        Polyline(
            polylineId: PolylineId('locationdirection'),
            width: 8,
            jointType: JointType.mitered,
            endCap: Cap.roundCap,
            startCap: Cap.roundCap,
            color: AppTheme.ORANGE,
            points: direction!.polylines_encoded
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList()),
      );
    });
    moveCameraBound(direction!.bound_ne, direction!.bound_sw);

    
     final enabled = await SharedPreferencesManager.getEnableRouteVoice();

     if(enabled){
       Future.delayed(Duration(seconds: 2),(){

      TextToSpeechController.speak(VoiceAiSpeech.realtimeNavigation);

    });
     }
   

  
  }

  void moveCameraBound(LatLng northeast, LatLng southwest) {
    LatLngBounds bound =
        LatLngBounds(southwest: southwest, northeast: northeast);
    _newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(bound, 35));
  }

  void clearRoute() {
    if (direction != null) {
      setState(() {
        direction = null;
        polylineSet = {};
      });
    }
    moveCamera(LatLng(widget.touristspot!.latitude as double,
        widget.touristspot!.longtitude as double));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.30,
              right: 8.0,
              left: 8.0,
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            markers: markerSet,
            circles: circleSet,
            polylines: polylineSet,
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.30,
                minHeight: MediaQuery.of(context).size.height * 0.20,
              ),
              child: SingleChildScrollView(
                child: Column(
  children: [
    Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          // GestureDetector(
          //   onTap: () {
          //     // Handle the back button press
          //   },
          //   child: Icon(
          //     Icons.arrow_back_ios_new,
          //     size: 20,
          //     color: Colors.grey.shade600,
          //   ),
          // ),
          Text(
            'Location',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          if(direction==null) Container(),
          if(direction != null)GestureDetector(
            onTap: clearRoute,
            child: Icon(
              Icons.close,
              size: 24,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    ),
    Divider(color: Colors.grey.shade200),
    Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.1),
          //   blurRadius: 8,
          //   spreadRadius: 2,
          // ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (widget.touristspot?.formatted_address != null) {
                moveCamera(
                  LatLng(
                    widget.touristspot!.latitude as double,
                    widget.touristspot!.longtitude as double,
                  ),
                );
              }
            },
            child: Text(
              widget.touristspot!.formatted_address ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          if (direction != null) ...[
            SizedBox(height: 12),
            Text(
              'Total Distance: ${direction!.distanceText}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              'Duration: ${direction!.durationText}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 12),
           
           Text(
  'For the best navigation experience, we highly recommend using Google Maps. Make sure you have it installed on your device. To navigate, simply click the destination marker on the map. Two icons will appear: select the blue path icon to initiate navigation and select the map icon to view the location. ',
  style: TextStyle(fontSize: 12, color: Colors.grey),
),
            SizedBox(height: 12),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: clearRoute,
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.grey.shade200,
            //       onPrimary: Colors.grey.shade500,
            //       elevation: 0,
            //     ),
            //     child: Text('Clear'),
            //   ),
            // ),
          ],
          if (direction == null) ...[
            SizedBox(height: 12),
            GetBuilder<LocationController>(
              builder: (controller) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isGenerating.value
                        ? null
                        : () => getDirection(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.ORANGE,
                      foregroundColor: Colors.white,
                      elevation: 0,
                    ),
                    child: controller.isGenerating.value
                        ? Center(child: LoaderWidget(color: Colors.white))
                        : Text('Generate Route'),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    ),
  ],
),

              ),
            ).animate().scale(
                duration: Duration(milliseconds: 400), curve: Curves.easeInOut),
          ),
        ],
      ),
    );
  }
}
