import 'dart:convert';

class PlaceDetails {

 String? formatted_address;
 String? place_name;
 String? place_id;
 double? latitude;
 double? longitude;
  PlaceDetails({
    this.formatted_address,
    this.place_name,
    this.place_id,
    this.latitude,
    this.longitude,
  });
 

  PlaceDetails copyWith({
    String? formatted_address,
    String? place_name,
    String? place_id,
    double? latitude,
    double? longitude,
  }) {
    return PlaceDetails(
      formatted_address: formatted_address ?? this.formatted_address,
      place_name: place_name ?? this.place_name,
      place_id: place_id ?? this.place_id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'formatted_address': formatted_address,
      'place_name': place_name,
      'place_id': place_id,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory PlaceDetails.fromMap(Map<String, dynamic> map) {
    return PlaceDetails(
      formatted_address: map['formatted_address'],
      place_name: map['place_name'],
      place_id: map['place_id'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceDetails.fromJson(String source) => PlaceDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaceDetails(formatted_address: $formatted_address, place_name: $place_name, place_id: $place_id, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PlaceDetails &&
      other.formatted_address == formatted_address &&
      other.place_name == place_name &&
      other.place_id == place_id &&
      other.latitude == latitude &&
      other.longitude == longitude;
  }

  @override
  int get hashCode {
    return formatted_address.hashCode ^
      place_name.hashCode ^
      place_id.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
  }
}
