import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stream/core/constants/firebase_constants.dart';
import 'package:stream/core/providers/firebase_provider.dart';
import 'package:stream/core/type_defs.dart';
import 'package:stream/models/notifications_model.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/utils/failure.dart';
part '../repositories/notifications_repository.providers.dart';

class NotificationsRepository {
  final FirebaseFirestore _firestore;
  NotificationsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //! getters
  CollectionReference get _notifications =>
      _firestore.collection(FirebaseConstants.notificationsCollection);

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);

  //! send notification
  FutureVoid sendNotification({
    required NotificationsModel notification,
  }) async {
    try {
      return right(
          _notifications.doc(notification.notifId).set(notification.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! get users notifications
  Stream<List<NotificationsModel>> getUserNotifications({
    required UserModel user,
  }) {
    return _notifications
        .orderBy('createdAt', descending: true)
        .where('receiverUid', isEqualTo: user.uid)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) =>
                  NotificationsModel.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList());
  }

  //! delete notification
  FutureVoid deleteNotification({
    required PostModel post,
  }) async {
    try {
      return right(_notifications.doc(post.id).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
