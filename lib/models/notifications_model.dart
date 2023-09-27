// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationsModel {
  final String? notifId;
  final String? actorUid;
  final String? receiverUid;
  final String? type;
  final String? postId;
  final String? postContent;
  final String? postImage;
  final String? notificationContent;
  final String? notificationImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const NotificationsModel({
    this.notifId,
    this.actorUid,
    this.receiverUid,
    this.type,
    this.postId,
    this.postContent,
    this.postImage,
    this.notificationContent,
    this.notificationImage,
    this.createdAt,
    this.updatedAt,
  });

  NotificationsModel copyWith({
    String? notifId,
    String? actorUid,
    String? receiverUid,
    String? type,
    String? postId,
    String? postContent,
    String? postImage,
    String? notificationContent,
    String? notificationImage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotificationsModel(
      notifId: notifId ?? this.notifId,
      actorUid: actorUid ?? this.actorUid,
      receiverUid: receiverUid ?? this.receiverUid,
      type: type ?? this.type,
      postId: postId ?? this.postId,
      postContent: postContent ?? this.postContent,
      postImage: postImage ?? this.postImage,
      notificationContent: notificationContent ?? this.notificationContent,
      notificationImage: notificationImage ?? this.notificationImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notifId': notifId,
      'actorUid': actorUid,
      'receiverUid': receiverUid,
      'type': type,
      'postId': postId,
      'postImage': postImage,
      'notificationImage': notificationImage,
      'postContent': postContent,
      'notificationContent': notificationContent,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      notifId: map['notifId'] ?? '',
      actorUid: map['actorUid'] ?? '',
      receiverUid: map['receiverUid'] ?? '',
      type: map['type'] ?? '',
      postId: map['postId'] ?? '',
      postContent: map['postContent'] ?? '',
      postImage: map['postImage'] ?? '',
      notificationImage: map['notificationImage'] ?? '',
      notificationContent: map['notificationContent'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map["createdAt"] ?? 0))
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map["updatedAt"] ?? 0))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsModel.fromJson(String source) =>
      NotificationsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationsModel(notifId: $notifId, actorUid: $actorUid, receiverUid: $receiverUid, type: $type, postId: $postId, postContent: $postContent, postImage: $postImage, notificationContent: $notificationContent, notificationImage: $notificationImage, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant NotificationsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.notifId == notifId &&
      other.actorUid == actorUid &&
      other.receiverUid == receiverUid &&
      other.type == type &&
      other.postId == postId &&
      other.postContent == postContent &&
      other.postImage == postImage &&
      other.notificationContent == notificationContent &&
      other.notificationImage == notificationImage &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return notifId.hashCode ^
      actorUid.hashCode ^
      receiverUid.hashCode ^
      type.hashCode ^
      postId.hashCode ^
      postContent.hashCode ^
      postImage.hashCode ^
      notificationContent.hashCode ^
      notificationImage.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
