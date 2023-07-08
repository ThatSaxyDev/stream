import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream/core/providers/firebase_provider.dart';
import 'package:stream/features/posts/repositories/post_repository.dart';
part '../repositories/notifications_repository.providers.dart';

class NotificationsRepository {
  final FirebaseFirestore _firestore;
  NotificationsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
}
