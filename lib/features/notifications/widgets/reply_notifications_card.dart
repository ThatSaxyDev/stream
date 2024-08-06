import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/models/notifications_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/widgets/image_loader.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/app_constants.dart';

class ReplyNotificationsCard extends ConsumerWidget {
  final NotificationsModel notification;
  const ReplyNotificationsCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    UserModel ownUser = ref.watch(userProvider)!;
    UserModel? sender;
    ref
        .watch(getUserProvider(notification.actorUid!))
        .whenData((value) => sender = value);
    if (sender == null) {
      return const SizedBox.shrink();
    }
    return Container(
      width: width(context),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: currentTheme.textTheme.bodyMedium!.color!.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! profile pic
              SizedBox(
                height: 39.h,
                width: 34.w,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 17.w,
                      backgroundImage: NetworkImage(sender!.profilePic!),
                    ).tap(onTap: () {
                      Routemaster.of(context).push('/profile/${sender!.uid}');
                    }),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 10.w,
                        backgroundColor: Pallete.blueColor,
                        child: Icon(
                          PhosphorIconsBold.arrowBendDoubleUpLeft,
                          color: Pallete.whiteColor,
                          size: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              15.sbW,

              //! name. followers
              SizedBox(
                width: 250.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        sender!.isVerified! != true
                            ? sender!.username!.txt(
                                size: 15.sp,
                                fontWeight: FontWeight.w500,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Row(
                                children: [
                                  sender!.username!.txt(
                                    size: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  2.sbW,
                                  Icon(
                                    Icons.whatshot_sharp,
                                    size: 17.sp,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                        7.sbW,
                        'replied'.txt(
                            size: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: currentTheme.textTheme.bodyMedium!.color),
                        7.sbW,

                        //! time
                        timeago
                            .format(notification.createdAt!, locale: 'en_short')
                            .txt(
                                size: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: currentTheme.textTheme.bodyMedium!.color!
                                    .withOpacity(0.5)),
                      ],
                    ),
                    5.sbH,
                    if (notification.postContent!.isNotEmpty) ...[
                      notification.postContent!.txt(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          size: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: currentTheme.textTheme.bodyMedium!.color!
                              .withOpacity(0.5)),
                      5.sbH
                    ],
                    if (notification.postImage!.isNotEmpty) ...[
                      ImageLoader(
                        height: 30.h,
                        width: 30.w,
                        imageUrl: notification.postImage!,
                      ),
                      5.sbH
                    ],
                    notification.notificationContent!.txt(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      size: 15.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).tap(onTap: () {
      Routemaster.of(context).push('/post/${notification.postId}');
    });
  }
}
