import 'package:dirita_tourist_spot_app/models/review.dart';

class TouristSpot {
  String? userId;
  String? touristId;
  String? name;
  String? description;
  String? profile;
  double? latitude;
  double? longitude;
  List<String>? featuredImages;
  List<String>? featuredVideos;
  List<String>? visitors;
  List<Review>? reviews;

  TouristSpot({
    this.userId,
    this.touristId,
    this.name,
    this.description,
    this.profile,
    this.latitude,
    this.longitude,
    this.featuredImages,
    this.featuredVideos,
    this.visitors,
    this.reviews,
  });


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = userId;
    data['tourist_id'] = touristId;
    data['name'] = name;
    data['description'] = description;
    data['profile'] = profile;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['featured_images'] = featuredImages;
    data['featured_videos'] = featuredVideos;
    data['visitors'] = visitors;
    if (reviews != null) {
      data['reviews'] = reviews?.map((e) => e.toJson()).toList();
    }
    return data;
  }

  
}
