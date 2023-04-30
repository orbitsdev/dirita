import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dirita_tourist_spot_app/models/review.dart';

class TouristSpot {

  String? user_id;
  String? tourist_id;
  String? name;
  String? short_name;
  String? about;
  String? morei_nformation;
  double? latitude;
  double? longitude; 
  String? main_image;
  List<String>? featured_images;
  List<String>? shared_image;
  TouristSpot({
    this.user_id,
    this.tourist_id,
    this.name,
    this.short_name,
    this.about,
    this.morei_nformation,
    this.latitude,
    this.longitude,
    this.main_image,
    this.featured_images,
    this.shared_image,
  });
  

  TouristSpot copyWith({
    String? user_id,
    String? tourist_id,
    String? name,
    String? short_name,
    String? about,
    String? morei_nformation,
    double? latitude,
    double? longitude,
    String? main_image,
    List<String>? featured_images,
    List<String>? shared_image,
  }) {
    return TouristSpot(
      user_id: user_id ?? this.user_id,
      tourist_id: tourist_id ?? this.tourist_id,
      name: name ?? this.name,
      short_name: short_name ?? this.short_name,
      about: about ?? this.about,
      morei_nformation: morei_nformation ?? this.morei_nformation,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      main_image: main_image ?? this.main_image,
      featured_images: featured_images ?? this.featured_images,
      shared_image: shared_image ?? this.shared_image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'tourist_id': tourist_id,
      'name': name,
      'short_name': short_name,
      'about': about,
      'morei_nformation': morei_nformation,
      'latitude': latitude,
      'longitude': longitude,
      'main_image': main_image,
      'featured_images': featured_images,
      'shared_image': shared_image,
    };
  }

  factory TouristSpot.fromMap(Map<String, dynamic> map) {
    return TouristSpot(
      user_id: map['user_id'],
      tourist_id: map['tourist_id'],
      name: map['name'],
      short_name: map['short_name'],
      about: map['about'],
      morei_nformation: map['morei_nformation'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      main_image: map['main_image'],
      featured_images: List<String>.from(map['featured_images']),
      shared_image: List<String>.from(map['shared_image']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TouristSpot.fromJson(String source) => TouristSpot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TouristSpot(user_id: $user_id, tourist_id: $tourist_id, name: $name, short_name: $short_name, about: $about, morei_nformation: $morei_nformation, latitude: $latitude, longitude: $longitude, main_image: $main_image, featured_images: $featured_images, shared_image: $shared_image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TouristSpot &&
      other.user_id == user_id &&
      other.tourist_id == tourist_id &&
      other.name == name &&
      other.short_name == short_name &&
      other.about == about &&
      other.morei_nformation == morei_nformation &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.main_image == main_image &&
      listEquals(other.featured_images, featured_images) &&
      listEquals(other.shared_image, shared_image);
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
      tourist_id.hashCode ^
      name.hashCode ^
      short_name.hashCode ^
      about.hashCode ^
      morei_nformation.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      main_image.hashCode ^
      featured_images.hashCode ^
      shared_image.hashCode;
  }
}
