// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VerificationModel {
  final String userId;
  final String matricNo;
  final String photoIdCard;
  final String verificationStatus;
  final DateTime createdAt;
  final String description;
  final String phoneNumber;
  const VerificationModel({
    required this.userId,
    required this.matricNo,
    required this.photoIdCard,
    required this.verificationStatus,
    required this.createdAt,
    required this.description,
    required this.phoneNumber,
  });

  VerificationModel copyWith({
    String? userId,
    String? matricNo,
    String? photoIdCard,
    String? verificationStatus,
    DateTime? createdAt,
    String? description,
    String? phoneNumber,
  }) {
    return VerificationModel(
      userId: userId ?? this.userId,
      matricNo: matricNo ?? this.matricNo,
      photoIdCard: photoIdCard ?? this.photoIdCard,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'matricNo': matricNo,
      'photoIdCard': photoIdCard,
      'verificationStatus': verificationStatus,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'description': description,
      'phoneNumber': phoneNumber,
    };
  }

  factory VerificationModel.fromMap(Map<String, dynamic> map) {
    return VerificationModel(
      userId: (map["userId"] ?? '') as String,
      matricNo: (map["matricNo"] ?? '') as String,
      photoIdCard: (map["photoIdCard"] ?? '') as String,
      verificationStatus: (map["verificationStatus"] ?? '') as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch((map["createdAt"]??0) as int),
      description: (map["description"] ?? '') as String,
      phoneNumber: (map["phoneNumber"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationModel.fromJson(String source) => VerificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VerificationModel(userId: $userId, matricNo: $matricNo, photoIdCard: $photoIdCard, verificationStatus: $verificationStatus, createdAt: $createdAt, description: $description, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant VerificationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.matricNo == matricNo &&
      other.photoIdCard == photoIdCard &&
      other.verificationStatus == verificationStatus &&
      other.createdAt == createdAt &&
      other.description == description &&
      other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      matricNo.hashCode ^
      photoIdCard.hashCode ^
      verificationStatus.hashCode ^
      createdAt.hashCode ^
      description.hashCode ^
      phoneNumber.hashCode;
  }
}
