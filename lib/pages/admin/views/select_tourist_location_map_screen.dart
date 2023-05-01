import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:dirita_tourist_spot_app/delegates/location_search_delegate.dart';
import 'package:dirita_tourist_spot_app/models/geo_model.dart';
import 'package:dirita_tourist_spot_app/pages/admin/controllers/tourist_spot_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/controller/geolocation_controller.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/rounded_card_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';

import '../../../utils/app_theme.dart';

class SelectTouristLocationSpotScreen extends StatefulWidget {

  GeoModel? selectedLocation;
   SelectTouristLocationSpotScreen({
    Key? key,
    this.selectedLocation,
  }) : super(key: key);
  @override
  _SelectTouristLocationSpotScreenState createState() =>
      _SelectTouristLocationSpotScreenState();
}

class _SelectTouristLocationSpotScreenState extends State<SelectTouristLocationSpotScreen> {
  final touristController = Get.find<TouristSpotController>();
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

    touristController.getLocationInformation(context: context, latlng: latlng);


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


    if(widget.selectedLocation != null && widget.selectedLocation!.formatted_address != null){ 

      LatLng latLng = LatLng(widget.selectedLocation!.latitude as double  ,  widget.selectedLocation!.longitude as double);
        setLocation(latLng);
    }else if(touristController.temporaryAddressInformation.value.formatted_address != null ){
        LatLng latLng = LatLng(touristController.temporaryAddressInformation.value.latitude as double  ,  touristController.temporaryAddressInformation.value.longitude as double);
        setLocation(latLng);
    }
    
   
    

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Location'),
        centerTitle: true,
        leading: IconButton(  
            onPressed: () { 

                if( widget.selectedLocation != null && widget.selectedLocation!.formatted_address != null  && touristController.temporaryAddressInformation.value.formatted_address != null){

                    Get.back(result: widget.selectedLocation);                        

                } else if( widget.selectedLocation != null && widget.selectedLocation!.formatted_address != null){
                       Get.back(result: GeoModel());      
                }else{
                     Get.back(result: null); 
                }
          
             
               
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () async {
                final response = await  showSearch(context: context, delegate: LocationSearchDelegate());

                if(response != null){
                    setLocation(response);
                }

              },
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
            child: GetBuilder<TouristSpotController>(
              builder:(controller)  => RoundedCardWidget(
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
                                child:controller.isRequesting.value ?  LoaderWidget(width: 20, height: 20,) :    Text(controller.temporaryAddressInformation.value.formatted_address != null ? controller.temporaryAddressInformation.value.formatted_address as String  :   'No location was selected  at this  moment  '),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VSpace(10),
                   Expanded(
                      child: Row(
                        children: [
                         if(controller.temporaryAddressInformation.value.formatted_address != null)   Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  
                                  controller.clearSelectedAddress();
                                  clearMap();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey.shade100,
                                  primary: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "Clear".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ).animate().scale(),
                        if(controller.temporaryAddressInformation.value.formatted_address != null)  HSpace(20),
                           if(controller.temporaryAddressInformation.value.formatted_address != null) Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  
                                        Get.back(result:  controller.temporaryAddressInformation.value);
                                },
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
                          ).animate().scale(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        
        ],
      ),

    );
  }
}
