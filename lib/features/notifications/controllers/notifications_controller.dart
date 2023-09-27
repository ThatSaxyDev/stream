import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stream/core/providers/storage_repository_provider.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/notifications/repositories/notifications_repository.dart';
import 'package:stream/models/notifications_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/utils/failure.dart';
import 'package:uuid/uuid.dart';

part '../controllers/notifications_controller.provider.dart';

class NotificationsController extends StateNotifier<bool> {
  final NotificationsRepository _notificationsRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;
  NotificationsController({
    required NotificationsRepository notificationsRepository,
    required StorageRepository storageRepository,
    required Ref ref,
  })  : _notificationsRepository = notificationsRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  //! send notification
  void sendNotification({
    required String actorUid,
    required String receiverUid,
    required String type,
    required String postId,
    required String postContent,
    required String notificationContent,
    required String notificationImage,
    required String postImage,
  }) async {
    String notifId = const Uuid().v1();

    final NotificationsModel notification = NotificationsModel(
      notifId: notifId,
      actorUid: actorUid,
      receiverUid: receiverUid,
      type: type,
      postId: postId,
      postContent: postContent,
      postImage: postImage,
      notificationImage: notificationImage,
      notificationContent: notificationContent,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    Either<Failure, void> res = await _notificationsRepository.sendNotification(
        notification: notification);

    res.fold((l) => null, (r) => null);
  }

  //! get users notifications
  Stream<List<NotificationsModel>> getUserNotifications() {
    UserModel user = _ref.read(userProvider)!;

    return _notificationsRepository.getUserNotifications(user: user);
  }
}

final typeOrder = ['like', 'follow', 'reply', 'quote', 'repost'];
