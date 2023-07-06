// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class BookmarksModel {
  final String postId;
  final List<String> bookmarkedBy;
  const BookmarksModel({
    required this.postId,
    required this.bookmarkedBy,
  });

  BookmarksModel copyWith({
    String? postId,
    List<String>? bookmarkedBy,
  }) {
    return BookmarksModel(
      postId: postId ?? this.postId,
      bookmarkedBy: bookmarkedBy ?? this.bookmarkedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'bookmarkedBy': bookmarkedBy,
    };
  }

  factory BookmarksModel.fromMap(Map<String, dynamic> map) {
    return BookmarksModel(
      postId: (map["postId"] ?? '') as String,
      bookmarkedBy: List<String>.from(((map['bookmarkedBy'] ?? const <String>[]) as List<String>),),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookmarksModel.fromJson(String source) =>
      BookmarksModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BookmarksModel(postId: $postId, bookmarkedBy: $bookmarkedBy)';

  @override
  bool operator ==(covariant BookmarksModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.postId == postId &&
      listEquals(other.bookmarkedBy, bookmarkedBy);
  }

  @override
  int get hashCode => postId.hashCode ^ bookmarkedBy.hashCode;
}
