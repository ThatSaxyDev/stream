// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class QuoteModel {
  final String? postId;
  final String? id;
  final String? replyingPostId;
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
  const QuoteModel({
    this.postId,
    this.id,
    this.replyingPostId,
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

  QuoteModel copyWith({
    String? postId,
    String? id,
    String? replyingPostId,
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
    return QuoteModel(
      postId: postId ?? this.postId,
      id: id ?? this.id,
      replyingPostId: replyingPostId ?? this.replyingPostId,
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
      'postId': postId,
      'id': id,
      'replyingPostId': replyingPostId,
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

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      postId: map['postId'] ?? '',
      id: map['id'] ?? '',
      replyingPostId: map['replyingPostId'] ?? '',
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
    return 'QuoteModel(postId: $postId, id: $id, replyingPostId: $replyingPostId, link: $link, imageUrl: $imageUrl, textContent: $textContent, commentCount: $commentCount, userUid: $userUid, createdAt: $createdAt, repostedBy: $repostedBy, bookmarkedBy: $bookmarkedBy, repliedTo: $repliedTo, likedBy: $likedBy)';
  }

  @override
  bool operator ==(covariant QuoteModel other) {
    if (identical(this, other)) return true;

    return other.postId == postId &&
        other.id == id &&
        other.replyingPostId == replyingPostId &&
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
    return postId.hashCode ^
        id.hashCode ^
        replyingPostId.hashCode ^
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
}
