// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationsModel {
  final String? notifId;
  final String? actorUid;
  final String? receiverUid;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const NotificationsModel({
    this.notifId,
    this.actorUid,
    this.receiverUid,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  NotificationsModel copyWith({
    String? notifId,
    String? actorUid,
    String? receiverUid,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotificationsModel(
      notifId: notifId ?? this.notifId,
      actorUid: actorUid ?? this.actorUid,
      receiverUid: receiverUid ?? this.receiverUid,
      type: type ?? this.type,
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
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      notifId: map['notifId'] != null ? map["notifId"] ?? '' as String : null,
      actorUid: map['actorUid'] != null ? map["actorUid"] ?? '' as String : null,
      receiverUid: map['receiverUid'] != null ? map["receiverUid"] ?? '' as String : null,
      type: map['type'] != null ? map["type"] ?? '' as String : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch((map["createdAt"]??0) ?? 0 as int) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch((map["updatedAt"]??0) ?? 0 as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsModel.fromJson(String source) => NotificationsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationsModel(notifId: $notifId, actorUid: $actorUid, receiverUid: $receiverUid, type: $type, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant NotificationsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.notifId == notifId &&
      other.actorUid == actorUid &&
      other.receiverUid == receiverUid &&
      other.type == type &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return notifId.hashCode ^
      actorUid.hashCode ^
      receiverUid.hashCode ^
      type.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
