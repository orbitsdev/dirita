import 'dart:convert';
import 'dart:io';

import 'package:dirita_tourist_spot_app/api/google_map_api.dart';
import 'package:dirita_tourist_spot_app/models/geo_model.dart';
import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TouristSpotController extends GetxController {

  var isCreating = false.obs;
  var touristspot = TouristSpot().obs;
  var isRequesting = false.obs;
  var temporaryAddressInformation = GeoModel().obs;


  void clearSelectedAddress(){
    temporaryAddressInformation(GeoModel());
    update();
  }

  void updateSelected(GeoModel geoModel){

    temporaryAddressInformation(geoModel);
    update();
  }

  void handleError(BuildContext context, e) {
    isRequesting(false);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  void createTouristSpot({
    required BuildContext context,
    required String name,
    required String shortname,
    required File main_image,
    required List<File> featured_image,
  }) {}

  void getLocationInformation(
      {required BuildContext context, required LatLng latlng}) async {
    try {
      isRequesting(true);
      update();
      
      final response = await GoogleMapApi.geoRequest(latlng);
      final data =response.data['results'][0];
      final plus_code =response.data['plus_code'];

   
      GeoModel geodata =GeoModel(
      place_id: data['place_id'],
      formatted_address: data['formatted_address'] ,
      latitude :data['geometry']['location']['lat'],
      longitude: data['geometry']['location']['lng'],
      compound_code:plus_code['compound_code'],
      global_code: plus_code['global_code'],
    );

      temporaryAddressInformation(geodata);
      isRequesting(false);
      update();
    } on PlatformException catch (e) {
      handleError(context, e);
    } on SocketException catch (e) {
      handleError(context, e);
    } catch (e) {
      handleError(context, e);
    }
  }
}
