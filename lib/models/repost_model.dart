import 'package:cloud_firestore/cloud_firestore.dart';

class RepostModel {
  final String? id;
  final String? repostedByUser;
  final String? postId;
  final DateTime? createdAt;

  RepostModel({
    this.id,
    this.repostedByUser,
    this.postId,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'repostedByUser': repostedByUser,
      'postId': postId,
      'createdAt': createdAt,
    };
  }

  factory RepostModel.fromMap(Map<String, dynamic> map) {
    return RepostModel(
      id: map['id'] ?? '',
      repostedByUser: map['repostedByUser'] ?? '',
      postId: map['postId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
