import 'dart:convert';

import 'package:flutter/foundation.dart';



class TouristSpot {

  String? user_uid;
  String? id;
  String? name;
  String? famouse_name;
  String? about_information;
  String? more_information;
  String? formatted_address;
  String? place_id;
  double? latitude;
  double? longtitude;
  String? cover_image;
  List<String>? featured_image;
  
  TouristSpot({
    this.user_uid,
    this.id,
    this.name,
    this.famouse_name,
    this.about_information,
    this.more_information,
    this.formatted_address,
    this.place_id,
    this.latitude,
    this.longtitude,
    this.cover_image,
    this.featured_image,
  });




  TouristSpot copyWith({
    String? user_uid,
    String? id,
    String? name,
    String? famouse_name,
    String? about_information,
    String? more_information,
    String? formatted_address,
    String? place_id,
    double? latitude,
    double? longtitude,
    String? cover_image,
    List<String>? featured_image,
  }) {
    return TouristSpot(
      user_uid: user_uid ?? this.user_uid,
      id: id ?? this.id,
      name: name ?? this.name,
      famouse_name: famouse_name ?? this.famouse_name,
      about_information: about_information ?? this.about_information,
      more_information: more_information ?? this.more_information,
      formatted_address: formatted_address ?? this.formatted_address,
      place_id: place_id ?? this.place_id,
      latitude: latitude ?? this.latitude,
      longtitude: longtitude ?? this.longtitude,
      cover_image: cover_image ?? this.cover_image,
      featured_image: featured_image ?? this.featured_image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_uid': user_uid,
      'id': id,
      'name': name,
      'famouse_name': famouse_name,
      'about_information': about_information,
      'more_information': more_information,
      'formatted_address': formatted_address,
      'place_id': place_id,
      'latitude': latitude,
      'longtitude': longtitude,
      'cover_image': cover_image,
      'featured_image': featured_image,
    };
  }

  factory TouristSpot.fromMap(Map<String, dynamic> map) {
    return TouristSpot(
      user_uid: map['user_uid'],
      id: map['id'],
      name: map['name'],
      famouse_name: map['famouse_name'],
      about_information: map['about_information'],
      more_information: map['more_information'],
      formatted_address: map['formatted_address'],
      place_id: map['place_id'],
      latitude: map['latitude']?.toDouble(),
      longtitude: map['longtitude']?.toDouble(),
      cover_image: map['cover_image'],
      featured_image: List<String>.from(map['featured_image']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TouristSpot.fromJson(String source) => TouristSpot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TouristSpot(user_uid: $user_uid, id: $id, name: $name, famouse_name: $famouse_name, about_information: $about_information, more_information: $more_information, formatted_address: $formatted_address, place_id: $place_id, latitude: $latitude, longtitude: $longtitude, cover_image: $cover_image, featured_image: $featured_image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TouristSpot &&
      other.user_uid == user_uid &&
      other.id == id &&
      other.name == name &&
      other.famouse_name == famouse_name &&
      other.about_information == about_information &&
      other.more_information == more_information &&
      other.formatted_address == formatted_address &&
      other.place_id == place_id &&
      other.latitude == latitude &&
      other.longtitude == longtitude &&
      other.cover_image == cover_image &&
      listEquals(other.featured_image, featured_image);
  }

  @override
  int get hashCode {
    return user_uid.hashCode ^
      id.hashCode ^
      name.hashCode ^
      famouse_name.hashCode ^
      about_information.hashCode ^
      more_information.hashCode ^
      formatted_address.hashCode ^
      place_id.hashCode ^
      latitude.hashCode ^
      longtitude.hashCode ^
      cover_image.hashCode ^
      featured_image.hashCode;
  }
}



