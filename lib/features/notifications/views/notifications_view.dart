// ignore_for_file: deprecated_member_use

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/notifications/controllers/notifications_controller.dart';
import 'package:stream/features/notifications/widgets/follow_notif_card.dart';
import 'package:stream/features/notifications/widgets/like_notif_card.dart';
import 'package:stream/features/notifications/widgets/reply_notifications_card.dart';
import 'package:stream/models/notifications_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/error_text.dart';
import 'package:stream/utils/loader.dart';

class NotificationsView extends ConsumerWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? ownUser = ref.watch(userProvider);
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    AsyncValue<List<NotificationsModel>> notificationsStream =
        ref.watch(getNotificationsProvider);
    return Scaffold(
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: currentTheme.scaffoldBackgroundColor,
        foregroundColor: currentTheme.textTheme.bodyMedium!.color,
        elevation: 0,
        centerTitle: false,
        title: 'Notifications'.txt(
          size: 24.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: notificationsStream.when(
        data: (List<NotificationsModel> notifications) {
          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Loadinggg(
                    height: 50.h,
                    duration: 5000,
                  ),
                  20.sbH,
                  'You have no notifications'.txt(
                    size: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            padding: EdgeInsets.zero,
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              NotificationsModel notification = notifications[index];

              if (notification.actorUid == ownUser!.uid) {
                return const SizedBox.shrink();
              }
              if (notification.type == 'reply') {
                return ReplyNotificationsCard(notification: notification);
              }
              if (notification.type == 'like') {
                return LikeNotificationsCard(notification: notification);
              }
              if (notification.type == 'follow') {
                return FollowNotificationsCard(notification: notification);
              }
              return const SizedBox.shrink();
            },
          );
        },
        error: (error, stackTrace) {
          error.toString().log();
          return const ErrorText(error: 'An error occurred');
        },
        loading: () => Loadinggg(
          height: 40.h,
        ),
      ),
    );
  }
}
