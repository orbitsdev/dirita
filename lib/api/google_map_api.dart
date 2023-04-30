





import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dirita_tourist_spot_app/config/google_map_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final dio = Dio();


class GoogleMapApi {



static Future<Response<dynamic>> geoRequest(LatLng latlng) async 
{
     final response = await dio.get('https://maps.googleapis.com/maps/api/geocode/json?latlng=${latlng.latitude},${latlng.longitude}&key=${GOOGLE_MAP_API_KEY}');
     return response;
     
}   
}