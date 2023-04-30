



import 'dart:io';

import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TouristSpotController  extends GetxController{

  var isCreating  = false.obs;
  var touristspot = TouristSpot().obs;


  void createTouristSpot({required BuildContext context,  required String name, required String shortname, required File main_image, required List<File> featured_image,} ){

  }

}