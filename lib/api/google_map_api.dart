





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

static Future<Response<dynamic>> placeApiRequest(String place) async 
{
     final response = await dio.get('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${place}&key=${GOOGLE_MAP_API_KEY}&components:country:ph');
     return response;
     
}   

static Future<Response<dynamic>> placeDetailsRequest(String place_id) async 
{


     final response = await dio.get('https://maps.googleapis.com/maps/api/place/details/json?place_id=${place_id}&components=country:ph&key=${GOOGLE_MAP_API_KEY}');
     return response;
     
}   




}