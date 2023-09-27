import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream/core/providers/storage_repository_provider.dart';
import 'package:stream/core/utils.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/notifications/controllers/notifications_controller.dart';
import 'package:stream/features/profile/repositories/profile_repository.dart';
import 'package:stream/models/user_model.dart';

part '../controllers/profile_controller.providers.dart';

class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepository _userProfileRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;
  UserProfileController({
    required UserProfileRepository userProfileRepository,
    required StorageRepository storageRepository,
    required Ref ref,
  })  : _userProfileRepository = userProfileRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  //! edit user profile
  void editUserProfile({
    required BuildContext context,
    required UserModel user,
  }) async {
    state = true;

    final res = await _userProfileRepository.editProfile(user);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        _ref.read(userProvider.notifier).update((state) => user);
      },
    );
  }

  //! edit user profile image
  void editUserProfileImage({
    required BuildContext context,
    required File? profileFile,
    Uint8List? file,
  }) async {
    state = true;
    UserModel user = _ref.read(userProvider)!;
    if (profileFile != null) {
      final res = await _storageRepository.storeFile(
        path: 'users/profile',
        id: user.uid!,
        file: profileFile,
        webFile: file,
      );
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => user = user.copyWith(profilePic: r),
      );
    }

    final res = await _userProfileRepository.editProfile(user);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        _ref.read(userProvider.notifier).update((state) => user);
      },
    );
  }

  //! follow user
  void followUser({required UserModel userToFollow}) async {
    UserModel user = _ref.read(userProvider)!;
    final res = await _userProfileRepository.followUser(
        userToFollow: userToFollow, ownUser: user);

    res.fold(
      (l) => null,
      (r) {
        if (r == 'followed') {
          //! send notification
          _ref.read(notificationsControllerProvider.notifier).sendNotification(
                actorUid: user.uid!,
                receiverUid: userToFollow.uid!,
                type: 'follow',
                postId: '',
                postContent: 'followed you',
                notificationContent: '',
                postImage: '',
                notificationImage: user.profilePic!,
              );
        }
        // if (r == 'unliked') {
        //   //! delete notification
        //   _ref.read(notificationsControllerProvider.notifier).sendNotification(
        //         actorUid: user.uid!,
        //         receiverUid: post.userUid!,
        //         type: 'like',
        //         postId: post.id!,
        //         postContent: post.textContent!,
        //         notificationContent: '',
        //         postImage: post.imageUrl!,
        //         notificationImage: '',
        //       );
        // }
      },
    );
  }
}
