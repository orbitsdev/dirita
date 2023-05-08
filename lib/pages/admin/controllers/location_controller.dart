import 'dart:io';

import 'package:dirita_tourist_spot_app/api/google_map_api.dart';
import 'package:dirita_tourist_spot_app/models/Direction.dart';
import 'package:dirita_tourist_spot_app/models/geo_model.dart';
import 'package:dirita_tourist_spot_app/models/place_details.dart';
import 'package:dirita_tourist_spot_app/pages/public/controller/geolocation_controller.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  var isLoading = false.obs;
  var isGenerating = false.obs;
  var currentLocationDetails = PlaceDetails().obs;

  void handleError(BuildContext context, e) {
    isGenerating(false);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  Future<PlaceDetails> getCurrentLocationDetails(LatLng latlng) async {
    try {
      isLoading(true);
      update();
    
      final response = await GoogleMapApi.geoRequest(latlng);
      final placeId = response.data['results'][0]['place_id'];
     
      final results =  await GoogleMapApi.placeDetailsRequest(placeId);
      final resuldata = results.data['result'];
        PlaceDetails new_place_details = PlaceDetails(
        
        formatted_address: resuldata['formatted_address'],
        place_name: resuldata['name'],
         place_id: resuldata['place_id'], 
         latitude: resuldata['geometry']['location']['lat'],
         longitude: resuldata['geometry']['location']['lng']
          );

      currentLocationDetails(new_place_details);
      isLoading(false);
      update();

      return new_place_details;
    } catch (e) {
      Modal.toast(message: e.toString());
      isLoading(false);
      update();
      throw e;
    }
  }

  Future<Direction> getDirection(
      {required BuildContext context,
      required LatLng destination,
      LatLng? devicelocation}) async {
    try {
      isGenerating(true);
      update();
      LatLng device_position;

      if (devicelocation != null) {
        device_position = devicelocation;
      } else {
        Position position = await GeolocationController.determinePosition();
        device_position = LatLng(position.latitude, position.longitude);
      }

      final response = await GoogleMapApi.getDirectionRequest(origin: device_position, destination: destination);
        
      Direction generatedDirection  = Direction.fromMap(response);
    
      isGenerating(false);
      update();

      return generatedDirection;
    } on PlatformException catch (e) {
      handleError(context, e);
            throw e.toString();

    } on SocketException catch (e) {
      handleError(context, e);
      throw e.toString();
    } catch (e) {
      handleError(context, e);
      throw e.toString();
    }
  }
}
