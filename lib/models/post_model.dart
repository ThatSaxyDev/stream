// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  final String id;
  final String title;
  final String? link;
  final String? imageUrl;
  final String? description;
  final String communityName;
  final String communityProfilePic;
  final List<String> upvotes;
  final List<String> downvotes;
  final int commentCount;
  final String username;
  final String uid;
  final String type;
  final DateTime createdAt;
  final List<String> awards;
  final List<String> bookmarkedBy;
  const Post({
    required this.id,
    required this.title,
    this.link,
    this.imageUrl,
    this.description,
    required this.communityName,
    required this.communityProfilePic,
    required this.upvotes,
    required this.downvotes,
    required this.commentCount,
    required this.username,
    required this.uid,
    required this.type,
    required this.createdAt,
    required this.awards,
    required this.bookmarkedBy,
  });

  Post copyWith({
    String? id,
    String? title,
    String? link,
    String? imageUrl,
    String? description,
    String? communityName,
    String? communityProfilePic,
    List<String>? upvotes,
    List<String>? downvotes,
    int? commentCount,
    String? username,
    String? uid,
    String? type,
    DateTime? createdAt,
    List<String>? awards,
    List<String>? bookmarkedBy,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      communityName: communityName ?? this.communityName,
      communityProfilePic: communityProfilePic ?? this.communityProfilePic,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      commentCount: commentCount ?? this.commentCount,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      awards: awards ?? this.awards,
      bookmarkedBy: bookmarkedBy ?? this.bookmarkedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'link': link,
      'imageUrl': imageUrl,
      'description': description,
      'communityName': communityName,
      'communityProfilePic': communityProfilePic,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'commentCount': commentCount,
      'username': username,
      'uid': uid,
      'type': type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'awards': awards,
      'bookmarkedBy': bookmarkedBy,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: (map["id"] ?? '') as String,
      title: (map["title"] ?? '') as String,
      link: map['link'] != null ? map["link"] ?? '' as String : null,
      imageUrl: map['imageUrl'] != null ? map["imageUrl"] ?? '' as String : null,
      description: map['description'] != null ? map["description"] ?? '' as String : null,
      communityName: (map["communityName"] ?? '') as String,
      communityProfilePic: (map["communityProfilePic"] ?? '') as String,
      upvotes: List<String>.from(map['upvotes']),
      downvotes: List<String>.from(map['downvotes']),
      commentCount: (map["commentCount"] ?? 0) as int,
      username: (map["username"] ?? '') as String,
      uid: (map["uid"] ?? '') as String,
      type: (map["type"] ?? '') as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch((map["createdAt"]??0) as int),
      awards: List<String>.from(map['awards']),
      bookmarkedBy: List<String>.from(map['bookmarkedBy']),
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, title: $title, link: $link, imageUrl: $imageUrl, description: $description, communityName: $communityName, communityProfilePic: $communityProfilePic, upvotes: $upvotes, downvotes: $downvotes, commentCount: $commentCount, username: $username, uid: $uid, type: $type, createdAt: $createdAt, awards: $awards, bookmarkedBy: $bookmarkedBy)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.link == link &&
      other.imageUrl == imageUrl &&
      other.description == description &&
      other.communityName == communityName &&
      other.communityProfilePic == communityProfilePic &&
      listEquals(other.upvotes, upvotes) &&
      listEquals(other.downvotes, downvotes) &&
      other.commentCount == commentCount &&
      other.username == username &&
      other.uid == uid &&
      other.type == type &&
      other.createdAt == createdAt &&
      listEquals(other.awards, awards) &&
      listEquals(other.bookmarkedBy, bookmarkedBy);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      link.hashCode ^
      imageUrl.hashCode ^
      description.hashCode ^
      communityName.hashCode ^
      communityProfilePic.hashCode ^
      upvotes.hashCode ^
      downvotes.hashCode ^
      commentCount.hashCode ^
      username.hashCode ^
      uid.hashCode ^
      type.hashCode ^
      createdAt.hashCode ^
      awards.hashCode ^
      bookmarkedBy.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
