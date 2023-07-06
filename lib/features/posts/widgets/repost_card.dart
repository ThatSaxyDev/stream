// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/base_nav/views/base_nav_view.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/features/posts/widgets/create_post_bottom_sheet.dart';
import 'package:stream/features/posts/widgets/reply_post_bottom_sheet.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/repost_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/nav.dart';
import 'package:stream/utils/widgets/click_button.dart';
import 'package:stream/utils/widgets/image_loader.dart';
import 'package:timeago/timeago.dart' as timeago;

class RepostPostCard extends ConsumerWidget {
  final RepostModel repost;
  final PostModel post;
  const RepostPostCard({
    super.key,
    required this.post,
    required this.repost,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? userr = ref.watch(userProvider);
    int indexFromController = ref.watch(baseNavControllerProvider);
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    UserModel? user;
    UserModel? repostingUser;

    ref.watch(getUserProvider(post.userUid!)).whenData((value) => user = value);
    if (user == null) {
      return const SizedBox.shrink();
    }

    ref
        .watch(getUserProvider(repost.repostedByUser!))
        .whenData((value) => repostingUser = value);
    if (repostingUser == null) {
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
      child: Column(
        children: [
          //! reposted
          Row(
            children: [
              Icon(
                PhosphorIcons.repeat,
                color:
                    currentTheme.textTheme.bodyMedium!.color!.withOpacity(0.3),
                size: 18.sp,
              ),
              10.sbW,
              repostingUser!.uid! == userr!.uid!
                  ? 'You reposted'.txt(
                      color: currentTheme.textTheme.bodyMedium!.color!
                          .withOpacity(0.3),
                    )
                  : '@${repostingUser!.name!}'.txt(
                      color: currentTheme.textTheme.bodyMedium!.color!
                          .withOpacity(0.3),
                    )
            ],
          ),
          10.sbH,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 15.w,
                    backgroundImage: NetworkImage(user!.profilePic!),
                  ).tap(onTap: () {
                    if (post.userUid == userr.uid && indexFromController != 3) {
                      moveToPage(
                        context: context,
                        ref: ref,
                        index: 3,
                      );
                    }
                  }),
                ],
              ),
              10.sbW,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //! user name
                      '@${user!.name!}'.toLowerCase().txt(
                            size: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                      (width(context) * 0.36).sbW,
                      //! time, menu
                      timeago.format(post.createdAt!, locale: 'en_short').txt(
                            size: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                      7.sbW,
                      const Icon(PhosphorIcons.dotsThreeBold).tap(
                        onTap: () {
                          //! delete post
                          showModalBottomSheet(
                            isScrollControlled: true,
                            enableDrag: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => Wrap(
                              children: [
                                Container(
                                  height: 100.h,
                                  width: width(context),
                                  decoration: BoxDecoration(
                                    color: currentTheme.backgroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 40.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        color: currentTheme
                                            .textTheme.bodyMedium!.color!
                                            .withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Pallete.thickRed,
                                            size: 20.sp,
                                          ),
                                          7.sbW,
                                          Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Pallete.thickRed,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).tap(onTap: () {
                                      goBackk(context);
                                      // if (Platform.isAndroid) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Delete post?'),
                                            content: const Text(
                                                'You won\'t be able to restore it'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  goBackk(context);
                                                },
                                                child: 'Cancel'.txt(
                                                    color: currentTheme
                                                        .textTheme
                                                        .bodyMedium!
                                                        .color),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                          postControllerProvider
                                                              .notifier)
                                                      .deletePost(
                                                          post: post,
                                                          context: context);
                                                  goBackk(context);
                                                },
                                                child: 'Delete'.txt(
                                                    color: Pallete.thickRed),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      // } else {
                                      //   showDialog(
                                      //     context: context,
                                      //     builder: (context) {
                                      //       return CupertinoAlertDialog(
                                      //         title: const Text('Delete post?'),
                                      //         content: const Text(
                                      //             'You won\'t be able to restore it'),
                                      //         actions: <Widget>[
                                      //           TextButton(
                                      //             onPressed: () {
                                      //               goBackk(context);
                                      //             },
                                      //             child: const Text('Cancel'),
                                      //           ),
                                      //           TextButton(
                                      //             onPressed: () {
                                      //               goBackk(context);
                                      //             },
                                      //             child: const Text('Delete'),
                                      //           ),
                                      //         ],
                                      //       );
                                      //     },
                                      //   );
                                      // }
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),

                  //! content
                  if (post.textContent!.isNotEmpty) ...[
                    2.sbH,
                    SizedBox(
                      width: width(context) * 0.8,
                      child: SelectableText(
                        post.textContent!,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],

                  //! image
                  if (post.imageUrl!.isNotEmpty) ...[
                    10.sbH,
                    ImageLoader(
                      height: 250.h,
                      width: 200.w,
                      imageUrl: post.imageUrl!,
                    ),
                  ],
                  // 20.sbH,

                  SizedBox(
                    width: width(context) * 0.75,
                    child: Row(
                      children: [
                        //! repost
                        IconButton(
                          padding: EdgeInsets.zero,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            ref
                                .read(postControllerProvider.notifier)
                                .rePost(context: context, post: post);
                          },
                          icon: Icon(
                            PhosphorIcons.repeat,
                            color: post.repostedBy!.contains(userr!.uid)
                                ? Pallete.activegreen
                                : currentTheme.textTheme.bodyMedium!.color,
                          ),
                        ),
                        if (post.repostedBy!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: post.repostedBy!.length.toString().txt(),
                          ),

                        //! like
                        IconButton(
                          padding: EdgeInsets.zero,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            ref
                                .read(postControllerProvider.notifier)
                                .likePost(post: post);
                          },
                          icon: post.likedBy!.contains(userr.uid)
                              ? const Icon(
                                  PhosphorIcons.heartFill,
                                  color: Pallete.thickRed,
                                )
                              : const Icon(PhosphorIcons.heart),
                        ),
                        if (post.likedBy!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: post.likedBy!.length.toString().txt(),
                          ),

                        //! reply
                        IconButton(
                          padding: EdgeInsets.zero,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              enableDrag: false,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Wrap(
                                children: [
                                  ReplyPostBottomSheet(post: post),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(PhosphorIcons.chatCentered),
                        ),
                        if (post.repliedTo!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: post.repliedTo!.length.toString().txt(),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}