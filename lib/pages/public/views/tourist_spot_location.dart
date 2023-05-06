





import 'dart:async';

import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/rounded_card_widget.dart';
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

   
    setInitialMarker();
    
  }

  void setLocation(LatLng latlng){ 
    
    setMarker(latlng);
    setCircle(latlng);
    moveCamera(latlng);



  }


  void clearMap(){

    setState(() {
      
        markerSet.clear();
        circleSet.clear();
    });
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

  void setInitialMarker(){


      if(widget.touristspot!.place_id != null){

      LatLng latLng = LatLng(widget.touristspot!.latitude as double  ,  widget.touristspot!.longtitude as double);
        setLocation(latLng);
      }
    
   
    

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(

            fit: StackFit.expand,
        children: [
          GoogleMap(


            padding:   EdgeInsets.only(
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
            bottom: 16,
            right: 14,
            left: 14,
            child:Container(
              decoration: BoxDecoration(
                   color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
             constraints: BoxConstraints(
              maxHeight:MediaQuery.of(context).size.height * 0.20 ,
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
                          
                          Text('Location', style: TextStyle(),),
                          Container(
                            height: 34,
                          )
                          // SizedBox(
                          //   height: 34,
                          //   width: 34,
                          //   child: IconButton(
                          //     style:ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade100), onPressed: (){}, 
                          //     icon: Center(child: Icon(Icons.close,size:  20,  color: Colors.grey.shade600,
                          //     ),
                          //     ),
                          //     ),
                          //     ),
                          
                        ],
                      ),
                      Divider(
                          color: Colors.grey.shade200,
                          ),
                        Column(
                          children: [
                                    VSpace(10),

                                    GestureDetector(
                                      onTap: ()=> widget.touristspot?.formatted_address != null ? moveCamera(LatLng(widget.touristspot?.latitude as double, widget.touristspot?.longtitude as double) )  :null  ,
                                      child: Text('${widget.touristspot!.formatted_address}')),

                          
                          ],
                        ),
                        
                    VSpace(10),
                  Text('For Realtime Navigation, Click the marker the marker and click blue path',style: TextStyle(fontSize: 14),)

                  ],
                ),
              ),
              
            ).animate().scale(duration: Duration(milliseconds: 400), curve: Curves.easeInOut),


          ),
        ],
      ),
     
    );
  
  }
}