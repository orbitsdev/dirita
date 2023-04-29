import 'dart:convert';



class Review {

String? spot_id;
String?  user_id;
String? body;
String? created_at;
double? rating;
  Review({
    this.spot_id,
    this.user_id,
    this.body,
    this.created_at,
    this.rating,
  });



  Review copyWith({
    String? spot_id,
    String? user_id,
    String? body,
    String? created_at,
    double? rating,
  }) {
    return Review(
      spot_id: spot_id ?? this.spot_id,
      user_id: user_id ?? this.user_id,
      body: body ?? this.body,
      created_at: created_at ?? this.created_at,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'spot_id': spot_id,
      'user_id': user_id,
      'body': body,
      'created_at': created_at,
      'rating': rating,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      spot_id: map['spot_id'],
      user_id: map['user_id'],
      body: map['body'],
      created_at: map['created_at'],
      rating: map['rating']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Review(spot_id: $spot_id, user_id: $user_id, body: $body, created_at: $created_at, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Review &&
      other.spot_id == spot_id &&
      other.user_id == user_id &&
      other.body == body &&
      other.created_at == created_at &&
      other.rating == rating;
  }

  @override
  int get hashCode {
    return spot_id.hashCode ^
      user_id.hashCode ^
      body.hashCode ^
      created_at.hashCode ^
      rating.hashCode;
  }
}
