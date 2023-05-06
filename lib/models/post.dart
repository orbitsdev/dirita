import 'dart:convert';

class Post {


final String uid;
final String  id;
final String tourist_spot_id;
final String? post_image;
final String caption;
final String created_at;
  Post({
    required this.uid,
    required this.id,
    required this.tourist_spot_id,
    this.post_image,
    required this.caption,
    required this.created_at,
  });
 

  Post copyWith({
    String? uid,
    String? id,
    String? tourist_spot_id,
    String? post_image,
    String? caption,
    String? created_at,
  }) {
    return Post(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      tourist_spot_id: tourist_spot_id ?? this.tourist_spot_id,
      post_image: post_image ?? this.post_image,
      caption: caption ?? this.caption,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'tourist_spot_id': tourist_spot_id,
      'post_image': post_image,
      'caption': caption,
      'created_at': created_at,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      uid: map['uid'] ?? '',
      id: map['id'] ?? '',
      tourist_spot_id: map['tourist_spot_id'] ?? '',
      post_image: map['post_image'],
      caption: map['caption'] ?? '',
      created_at: map['created_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(uid: $uid, id: $id, tourist_spot_id: $tourist_spot_id, post_image: $post_image, caption: $caption, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Post &&
      other.uid == uid &&
      other.id == id &&
      other.tourist_spot_id == tourist_spot_id &&
      other.post_image == post_image &&
      other.caption == caption &&
      other.created_at == created_at;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      id.hashCode ^
      tourist_spot_id.hashCode ^
      post_image.hashCode ^
      caption.hashCode ^
      created_at.hashCode;
  }
}
