import 'dart:convert';

import 'package:dirita_tourist_spot_app/utils/asset.dart';

class UserAccount {

String? uid;
String? email;
String? first_name;
String? last_name;
String? profile_image;
String? role;

  UserAccount({
    this.uid,
    this.email,
    this.first_name,
    this.last_name,
    this.profile_image= Asset.avatarDefault,
    this.role = 'tourist',
  });


  UserAccount copyWith({
    String? uid,
    String? email,
    String? first_name,
    String? last_name,
    String? profile_image,
    String? role,
  }) {

    return UserAccount(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      profile_image: profile_image ?? this.profile_image,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'profile_image': profile_image,
      'role': role,
    };
  }

  factory UserAccount.fromMap(Map<String, dynamic> map) {
    return UserAccount(
      uid: map['uid'],
      email: map['email'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      profile_image: map['profile_image'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAccount.fromJson(String source) => UserAccount.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserAccount(uid: $uid, email: $email, first_name: $first_name, last_name: $last_name, profile_image: $profile_image, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserAccount &&
      other.uid == uid &&
      other.email == email &&
      other.first_name == first_name &&
      other.last_name == last_name &&
      other.profile_image == profile_image &&
      other.role == role;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      first_name.hashCode ^
      last_name.hashCode ^
      profile_image.hashCode ^
      role.hashCode;
  }
}
