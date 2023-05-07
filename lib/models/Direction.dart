



import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Direction {

  LatLng bound_ne;
  LatLng bound_sw;
  LatLng startlocation;
  LatLng endlocation;
  String polylines;
  List<PointLatLng> polylines_encoded;
  String distanceText;
  String durationText;
  int distanceValue;
  int durationValue;

  Direction({
    required this.bound_ne,
    required this.bound_sw,
    required this.startlocation,
    required this.endlocation,
    required this.polylines,
    required this.polylines_encoded,
    required this.distanceText,
    required this.durationText,
    required this.distanceValue,
    required this.durationValue,
  });


factory Direction.fromMap(Response<dynamic> response) {
  // Extract necessary data from the response
  final routes = response.data['routes'];
  final bounds = routes[0]['bounds'];
  final northeast = bounds['northeast'];
  final southwest = bounds['southwest'];
  final startLocation = routes[0]['legs'][0]['start_location'];
  final endLocation = routes[0]['legs'][0]['end_location'];
  final polyline = routes[0]['overview_polyline']['points'];
  final distanceText = routes[0]['legs'][0]['distance']['text'];
  final durationText = routes[0]['legs'][0]['duration']['text'];
  final distanceValue = routes[0]['legs'][0]['distance']['value'];
  final durationValue = routes[0]['legs'][0]['duration']['value'];

  // Create a LatLng instance for bound_ne and bound_sw
  final boundNE = LatLng(northeast['lat'], northeast['lng']);
  final boundSW = LatLng(southwest['lat'], southwest['lng']);

  // Decode the polyline into a list of PointLatLng instances
  final polylinePoints = PolylinePoints().decodePolyline(polyline);
  final polylinesEncoded = polylinePoints.map((point) {
    return PointLatLng(point.latitude, point.longitude);
  }).toList();

  // Create and return a Direction instance
  return Direction(
    bound_ne: boundNE,
    bound_sw: boundSW,
    startlocation: LatLng(startLocation['lat'], startLocation['lng']),
    endlocation: LatLng(endLocation['lat'], endLocation['lng']),
    polylines: polyline,
    polylines_encoded: polylinesEncoded,
    distanceText: distanceText,
    durationText: durationText,
    distanceValue: distanceValue,
    durationValue: durationValue,
  );
}
  }





   


  

