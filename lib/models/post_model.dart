// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PostModel {
  final String? id;
  final String? link;
  final String? imageUrl;
  final String? textContent;
  final int? commentCount;
  final String? userUid;
  final DateTime? createdAt;
  final List<dynamic>? repostedBy;
  final List<dynamic>? bookmarkedBy;
  final List<dynamic>? repliedTo;
  final List<dynamic>? likedBy;
  const PostModel({
    required this.id,
    this.link,
    this.imageUrl,
    this.textContent,
    this.commentCount,
    this.userUid,
    this.createdAt,
    this.repostedBy,
    this.bookmarkedBy,
    this.repliedTo,
    this.likedBy,
  });

  PostModel copyWith({
    String? id,
    String? link,
    String? imageUrl,
    String? textContent,
    int? commentCount,
    String? userUid,
    DateTime? createdAt,
    List<dynamic>? repostedBy,
    List<dynamic>? bookmarkedBy,
    List<dynamic>? repliedTo,
    List<dynamic>? likedBy,
  }) {
    return PostModel(
      id: id ?? this.id,
      link: link ?? this.link,
      imageUrl: imageUrl ?? this.imageUrl,
      textContent: textContent ?? this.textContent,
      commentCount: commentCount ?? this.commentCount,
      userUid: userUid ?? this.userUid,
      createdAt: createdAt ?? this.createdAt,
      repostedBy: repostedBy ?? this.repostedBy,
      bookmarkedBy: bookmarkedBy ?? this.bookmarkedBy,
      repliedTo: repliedTo ?? this.repliedTo,
      likedBy: likedBy ?? this.likedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'link': link,
      'imageUrl': imageUrl,
      'textContent': textContent,
      'commentCount': commentCount,
      'userUid': userUid,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'repostedBy': repostedBy,
      'bookmarkedBy': bookmarkedBy,
      'repliedTo': repliedTo,
      'likedBy': likedBy,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      link: map['link'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      textContent: map['textContent'] ?? '',
      commentCount: map['commentCount'] ?? 0,
      userUid: map['userUid'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map["createdAt"] ?? 0))
          : null,
      repostedBy: map['repostedBy'] ?? [],
      bookmarkedBy: map['bookmarkedBy'] ?? [],
      repliedTo: map['repliedTo'] ?? [],
      likedBy: map['likedBy'] ?? [],
    );
  }

  @override
  String toString() {
    return 'PostModel(id: $id, link: $link, imageUrl: $imageUrl, textContent: $textContent, commentCount: $commentCount, userUid: $userUid, createdAt: $createdAt, repostedBy: $repostedBy, bookmarkedBy: $bookmarkedBy, repliedTo: $repliedTo, likedBy: $likedBy)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.link == link &&
        other.imageUrl == imageUrl &&
        other.textContent == textContent &&
        other.commentCount == commentCount &&
        other.userUid == userUid &&
        other.createdAt == createdAt &&
        listEquals(other.repostedBy, repostedBy) &&
        listEquals(other.bookmarkedBy, bookmarkedBy) &&
        listEquals(other.repliedTo, repliedTo) &&
        listEquals(other.likedBy, likedBy);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        link.hashCode ^
        imageUrl.hashCode ^
        textContent.hashCode ^
        commentCount.hashCode ^
        userUid.hashCode ^
        createdAt.hashCode ^
        repostedBy.hashCode ^
        bookmarkedBy.hashCode ^
        repliedTo.hashCode ^
        likedBy.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
