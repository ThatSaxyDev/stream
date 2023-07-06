// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApplicationModel {
  final String userId;
  final String communityName;
  final String matricNo;
  final String photoIdCard;
  final String description;
  final String approvalStatus;
  final DateTime createdAt;
  final String phoneNumber;
  const ApplicationModel({
    required this.userId,
    required this.communityName,
    required this.matricNo,
    required this.photoIdCard,
    required this.description,
    required this.approvalStatus,
    required this.createdAt,
    required this.phoneNumber,
  });

  ApplicationModel copyWith({
    String? userId,
    String? communityName,
    String? matricNo,
    String? photoIdCard,
    String? description,
    String? approvalStatus,
    DateTime? createdAt,
    String? phoneNumber,
  }) {
    return ApplicationModel(
      userId: userId ?? this.userId,
      communityName: communityName ?? this.communityName,
      matricNo: matricNo ?? this.matricNo,
      photoIdCard: photoIdCard ?? this.photoIdCard,
      description: description ?? this.description,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      createdAt: createdAt ?? this.createdAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'communityName': communityName,
      'matricNo': matricNo,
      'photoIdCard': photoIdCard,
      'description': description,
      'approvalStatus': approvalStatus,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'phoneNumber': phoneNumber,
    };
  }

  factory ApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplicationModel(
      userId: (map["userId"] ?? '') as String,
      communityName: (map["communityName"] ?? '') as String,
      matricNo: (map["matricNo"] ?? '') as String,
      photoIdCard: (map["photoIdCard"] ?? '') as String,
      description: (map["description"] ?? '') as String,
      approvalStatus: (map["approvalStatus"] ?? '') as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch((map["createdAt"]??0) as int),
      phoneNumber: (map["phoneNumber"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplicationModel.fromJson(String source) =>
      ApplicationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApplicationModel(userId: $userId, communityName: $communityName, matricNo: $matricNo, photoIdCard: $photoIdCard, description: $description, approvalStatus: $approvalStatus, createdAt: $createdAt, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant ApplicationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.communityName == communityName &&
      other.matricNo == matricNo &&
      other.photoIdCard == photoIdCard &&
      other.description == description &&
      other.approvalStatus == approvalStatus &&
      other.createdAt == createdAt &&
      other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      communityName.hashCode ^
      matricNo.hashCode ^
      photoIdCard.hashCode ^
      description.hashCode ^
      approvalStatus.hashCode ^
      createdAt.hashCode ^
      phoneNumber.hashCode;
  }
}
