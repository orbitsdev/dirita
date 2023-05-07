import 'dart:io';

import 'package:dirita_tourist_spot_app/api/google_map_api.dart';
import 'package:dirita_tourist_spot_app/models/Direction.dart';
import 'package:dirita_tourist_spot_app/models/geo_model.dart';
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
  var currentLocationDetails = GeoModel().obs;

  void handleError(BuildContext context, e) {
    isGenerating(false);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  Future<GeoModel> getCurrentLocationDetails(LatLng latlng) async {
    try {
      isLoading(true);
      update();
      final response = await GoogleMapApi.geoRequest(latlng);
      final data = response.data['results'][0];
      final plus_code = response.data['plus_code'];

      GeoModel geodata = GeoModel(
        place_id: data['place_id'],
        formatted_address: data['formatted_address'],
        latitude: data['geometry']['location']['lat'],
        longitude: data['geometry']['location']['lng'],
      );

      currentLocationDetails(geodata);
      isLoading(false);
      update();

      return GeoModel();
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
