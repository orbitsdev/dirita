


import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoModel {

  String? place_id;
  String? formatted_address;
  double? latitude;
  double? longitude;
  String? compound_code;
  String? global_code;
  bool? isConfirmed;

  
  GeoModel({
    this.place_id,
    this.formatted_address,
    this.latitude,
    this.longitude,
    this.compound_code,
    this.global_code,
    this.isConfirmed,
  });



  GeoModel copyWith({
    String? place_id,
    String? formatted_address,
    double? latitude,
    double? longitude,
    String? compound_code,
    String? global_code,
    bool? isConfirmed,
  }) {
    return GeoModel(
      place_id: place_id ?? this.place_id,
      formatted_address: formatted_address ?? this.formatted_address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      compound_code: compound_code ?? this.compound_code,
      global_code: global_code ?? this.global_code,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'place_id': place_id,
      'formatted_address': formatted_address,
      'latitude': latitude,
      'longitude': longitude,
      'compound_code': compound_code,
      'global_code': global_code,
      'isConfirmed': isConfirmed,
    };
  }

  factory GeoModel.fromMap(Map<String, dynamic> map) {
    return GeoModel(
      place_id: map['place_id'],
      formatted_address: map['formatted_address'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      compound_code: map['compound_code'],
      global_code: map['global_code'],
      isConfirmed: map['isConfirmed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoModel.fromJson(String source) => GeoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GeoModel(place_id: $place_id, formatted_address: $formatted_address, latitude: $latitude, longitude: $longitude, compound_code: $compound_code, global_code: $global_code, isConfirmed: $isConfirmed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GeoModel &&
      other.place_id == place_id &&
      other.formatted_address == formatted_address &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.compound_code == compound_code &&
      other.global_code == global_code &&
      other.isConfirmed == isConfirmed;
  }

  @override
  int get hashCode {
    return place_id.hashCode ^
      formatted_address.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      compound_code.hashCode ^
      global_code.hashCode ^
      isConfirmed.hashCode;
  }
}
