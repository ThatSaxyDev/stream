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
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/nav.dart';
import 'package:stream/utils/widgets/click_button.dart';
import 'package:stream/utils/widgets/image_loader.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedReplyPostCard extends ConsumerWidget {
  final PostModel post;
  const FeedReplyPostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? userr = ref.watch(userProvider);
    int indexFromController = ref.watch(baseNavControllerProvider);
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    UserModel? replyingUser;
    UserModel? repliedUser;

    ref
        .watch(getUserProvider(post.userUid!))
        .whenData((value) => replyingUser = value);
    if (replyingUser == null) {
      return const SizedBox.shrink();
    }

    PostModel? repliedPost;
    ref.watch(getPostByIdProvider(post.replyingPostId!)).whenData((value) {
      repliedPost = value;
      ref
          .watch(getUserProvider(repliedPost!.userUid!))
          .whenData((value) => repliedUser = value);
      if (repliedUser == null) {
        return const SizedBox.shrink();
      }
    });

    return Column(
      children: [
        //! post replied to above
        Container(
          width: width(context),
          padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
            top: 13.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 15.w,
                    backgroundImage: NetworkImage(repliedUser!.profilePic!),
                  ).tap(onTap: () {
                    if (repliedPost!.userUid == userr!.uid &&
                        indexFromController != 3) {
                      moveToPage(
                        context: context,
                        ref: ref,
                        index: 3,
                      );
                    }
                  }),
                  20.sbH,
                  Container(
                    width: 0.5,
                    height: 40.h,
                    color: currentTheme.textTheme.bodyMedium!.color!,
                  ),
                  CircleAvatar(
                    radius: 4.w,
                    backgroundColor: currentTheme.textTheme.bodyMedium!.color!,
                  )
                ],
              ),
              10.sbW,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //! user name
                      '@${repliedUser!.name!}'.toLowerCase().txt(
                            size: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                      (width(context) * 0.36).sbW,
                      //! time, menu
                      timeago
                          .format(repliedPost!.createdAt!, locale: 'en_short')
                          .txt(
                            size: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                      7.sbW,
                      const Icon(PhosphorIcons.dotsThreeBold).tap(
                        onTap: () {
                          if (repliedPost!.userUid == userr!.uid &&
                              indexFromController != 3) {
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                          }
                        },
                      )
                    ],
                  ),

                  //! content
                  if (repliedPost!.textContent!.isNotEmpty) ...[
                    2.sbH,
                    SizedBox(
                      width: width(context) * 0.8,
                      child: SelectableText(
                        repliedPost!.textContent!,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],

                  //! image
                  if (repliedPost!.imageUrl!.isNotEmpty) ...[
                    10.sbH,
                    ImageLoader(
                      height: 250.h,
                      width: 200.w,
                      imageUrl: repliedPost!.imageUrl!,
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
                          onPressed: () {},
                          icon: const Icon(PhosphorIcons.repeat),
                        ),
                        if (repliedPost!.repostedBy!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: repliedPost!.repostedBy!.length
                                .toString()
                                .txt(),
                          ),

                        //! like
                        IconButton(
                          padding: EdgeInsets.zero,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            ref
                                .read(postControllerProvider.notifier)
                                .likePost(post: repliedPost!);
                          },
                          icon:
                              repliedPost!.likedBy!.contains(replyingUser!.uid)
                                  ? const Icon(
                                      PhosphorIcons.heartFill,
                                      color: Pallete.thickRed,
                                    )
                                  : const Icon(PhosphorIcons.heart),
                        ),
                        if (repliedPost!.likedBy!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child:
                                repliedPost!.likedBy!.length.toString().txt(),
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
                        if (repliedPost!.repliedTo!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child:
                                repliedPost!.repliedTo!.length.toString().txt(),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),

        //! replying post below
        Container(
          width: width(context),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
          decoration: BoxDecoration(
            // color: Colors.grey,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color:
                    currentTheme.textTheme.bodyMedium!.color!.withOpacity(0.1),
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 15.w,
                backgroundImage: NetworkImage(replyingUser!.profilePic!),
              ).tap(onTap: () {
                if (post.userUid == replyingUser!.uid &&
                    indexFromController != 3) {
                  moveToPage(
                    context: context,
                    ref: ref,
                    index: 3,
                  );
                }
              }),
              10.sbW,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //! user name
                      '@${replyingUser!.name!}'.toLowerCase().txt(
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
                          onPressed: () {},
                          icon: const Icon(PhosphorIcons.repeat),
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
                          icon: post.likedBy!.contains(replyingUser!.uid)
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
        ),
      ],
    );
  }
}
