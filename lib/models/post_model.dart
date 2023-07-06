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
  final List<String>? repostedBy;
  final List<String>? bookmarkedBy;
  final List<String>? repliedTo;
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
  });

  PostModel copyWith({
    String? id,
    String? link,
    String? imageUrl,
    String? textContent,
    int? commentCount,
    String? userUid,
    DateTime? createdAt,
    List<String>? repostedBy,
    List<String>? bookmarkedBy,
    List<String>? repliedTo,
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
      repostedBy: map['repostedBy'] != null
          ? List<String>.from(
              ((map['repostedBy']) as List<String>),
            )
          : null,
      bookmarkedBy: map['bookmarkedBy'] != null
          ? List<String>.from(
              ((map['bookmarkedBy']) as List<String>),
            )
          : null,
      repliedTo: map['repliedTo'] != null
          ? List<String>.from(
              ((map['repliedTo']) as List<String>),
            )
          : null,
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, link: $link, imageUrl: $imageUrl, textContent: $textContent, commentCount: $commentCount, userUid: $userUid, createdAt: $createdAt, repostedBy: $repostedBy, bookmarkedBy: $bookmarkedBy, repliedTo: $repliedTo)';
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
        listEquals(other.repliedTo, repliedTo);
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
        repliedTo.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
