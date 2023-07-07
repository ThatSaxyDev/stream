// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String? uid;
  final String? name;
  final String? username;
  final String? email;
  final String? profilePic;
  final String? banner;
  final String? link;
  final bool? isVerified;
  final List<dynamic>? followers;
  final List<dynamic>? following;

  const UserModel({
    this.uid,
    this.name,
    this.username,
    this.email,
    this.profilePic,
    this.banner,
    this.link,
    this.isVerified,
    this.followers,
    this.following,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? username,
    String? email,
    String? profilePic,
    String? banner,
    String? link,
    bool? isVerified,
    List<dynamic>? followers,
    List<dynamic>? following,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      banner: banner ?? this.banner,
      link: link ?? this.link,
      isVerified: isVerified ?? this.isVerified,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'username': username,
      'email': email,
      'link': link,
      'profilePic': profilePic,
      'banner': banner,
      'isVerified': isVerified,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? '',
      name: map["name"] ?? '',
      username: map["username"] ?? '',
      email: map["email"] ?? '',
      link: map["link"] ?? '',
      profilePic: map["profilePic"] ?? '',
      banner: map["banner"] ?? '',
      isVerified: map["isVerified"] ?? false,
      followers: map['followers'] ?? [],
      following: map['following'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, username: $username, email: $email, profilePic: $profilePic, banner: $banner, link: $link, isVerified: $isVerified, followers: $followers, following: $following)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.username == username &&
        other.email == email &&
        other.profilePic == profilePic &&
        other.banner == banner &&
        other.link == link &&
        other.isVerified == isVerified &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        username.hashCode ^
        email.hashCode ^
        profilePic.hashCode ^
        banner.hashCode ^
        link.hashCode ^
        isVerified.hashCode ^
        followers.hashCode ^
        following.hashCode;
  }
}
