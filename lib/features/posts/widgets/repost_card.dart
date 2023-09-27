// ignore_for_file: deprecated_member_use

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/base_nav/views/base_nav_view.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/features/posts/widgets/feed_quote_card.dart';
import 'package:stream/features/posts/widgets/reply_post_bottom_sheet.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/nav.dart';
import 'package:stream/utils/widgets/image_loader.dart';
import 'package:timeago/timeago.dart' as timeago;

class RepostPostCard extends ConsumerWidget {
  final PostModel post;
  const RepostPostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? userr = ref.watch(userProvider);
    int indexFromController = ref.watch(baseNavControllerProvider);
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    UserModel? user;
    UserModel? repostingUser;
    PostModel repostedPost;

    ref.watch(getUserProvider(post.userUid!)).whenData((value) => user = value);
    if (user == null) {
      return const SizedBox.shrink();
    }

    ref
        .watch(getUserProvider(post.repostingUser!))
        .whenData((value) => repostingUser = value);
    if (repostingUser == null) {
      return const SizedBox.shrink();
    }

    // ref.watch(getPostByIdProvider(post.replyingPostId!)).whenData((value) {
    //   repliedPost = value;
    //   ref
    //       .watch(getUserProvider(repliedPost!.userUid!))
    //       .whenData((value) => repliedUser = value);
    //   if (repliedUser == null) {
    //     return const SizedBox.shrink();
    //   }
    // });

    return post.quotingPostId!.isNotEmpty
        ? Column(
            children: [
              //! reposted
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.w).copyWith(top: 13.h),
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.repeat,
                      color: currentTheme.textTheme.bodyMedium!.color!
                          .withOpacity(0.4),
                      size: 18.sp,
                    ),
                    10.sbW,
                    repostingUser!.uid! == userr!.uid!
                        ? 'You reposted'.txt(
                            color: currentTheme.textTheme.bodyMedium!.color!
                                .withOpacity(0.4),
                          )
                        : '@${repostingUser!.name!}'.txt(
                            color: currentTheme.textTheme.bodyMedium!.color!
                                .withOpacity(0.4),
                          )
                  ],
                ),
              ),
              FeedQuotePostCard(post: post),
            ],
          ).tap(onTap: () {
            Routemaster.of(context).push('/post/${post.id}');
          })
        : Container(
            width: width(context),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: currentTheme.textTheme.bodyMedium!.color!
                      .withOpacity(0.1),
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
                      color: currentTheme.textTheme.bodyMedium!.color!
                          .withOpacity(0.4),
                      size: 18.sp,
                    ),
                    10.sbW,
                    repostingUser!.uid! == userr!.uid!
                        ? 'You reposted'.txt(
                            color: currentTheme.textTheme.bodyMedium!.color!
                                .withOpacity(0.4),
                          )
                        : '@${repostingUser!.username!}'.txt(
                            color: currentTheme.textTheme.bodyMedium!.color!
                                .withOpacity(0.4),
                          )
                  ],
                ),
                10.sbH,
                ref.watch(getPostByIdProvider(post.id!)).when(
                  data: (data) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CircularImageLoader(
                              imageUrl: user!.profilePic!,
                              dimension: 30.w,
                            ).tap(onTap: () {
                              if (data.userUid == userr.uid &&
                                  indexFromController != 3) {
                                moveToPage(
                                  context: context,
                                  ref: ref,
                                  index: 3,
                                );
                              } else {
                                Routemaster.of(context)
                                    .push('/profile/${post.userUid}');
                              }
                            }),
                          ],
                        ),
                        10.sbW,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width(context) * 0.8,
                              child: Row(
                                children: [
                                  //! user name
                                  user!.isVerified! != true
                                      ? '@${user!.username!}'
                                          .toLowerCase()
                                          .txt(
                                            size: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          )
                                      : Row(
                                          children: [
                                            '@${user!.username!}'
                                                .toLowerCase()
                                                .txt(
                                                  size: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                            2.sbW,
                                            Icon(
                                              Icons.whatshot_sharp,
                                              size: 17.sp,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                  const Spacer(),
                                  //! time, menu
                                  timeago
                                      .format(post.createdAt!,
                                          locale: 'en_short')
                                      .txt(
                                        size: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                  7.sbW,
                                   if(post.repostingUser == userr.uid)
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
                                                color: currentTheme
                                                    .backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Container(
                                                  height: 40.h,
                                                  width: 100.w,
                                                  decoration: BoxDecoration(
                                                    color: currentTheme
                                                        .textTheme
                                                        .bodyMedium!
                                                        .color!
                                                        .withOpacity(0.05),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                          color:
                                                              Pallete.thickRed,
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                        title: const Text(
                                                            'Delete post?'),
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
                                                                  .read(postControllerProvider
                                                                      .notifier)
                                                                  .deletePost(
                                                                      post:
                                                                          post,
                                                                      context:
                                                                          context);
                                                              goBackk(context);
                                                            },
                                                            child: 'Delete'.txt(
                                                                color: Pallete
                                                                    .thickRed),
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
                            ),

                            //! content
                            if (post.textContent!.isNotEmpty) ...[
                              2.sbH,
                              SizedBox(
                                width: width(context) * 0.8,
                                child: SelectableText(
                                  post.textContent!,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
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
                                      color:
                                          data.repostedBy!.contains(userr.uid)
                                              ? Pallete.activegreen
                                              : currentTheme
                                                  .textTheme.bodyMedium!.color,
                                    ),
                                  ),
                                  if (data.repostedBy!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(right: 5.w),
                                      child: data.repostedBy!.length
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
                                          .likePost(post: post);
                                    },
                                    icon: data.likedBy!.contains(userr.uid)
                                        ? const Icon(
                                            PhosphorIcons.heartFill,
                                            color: Pallete.thickRed,
                                          )
                                        : const Icon(PhosphorIcons.heart),
                                  ),
                                  if (data.likedBy!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(right: 5.w),
                                      child:
                                          data.likedBy!.length.toString().txt(),
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
                                    icon:
                                        const Icon(PhosphorIcons.chatCentered),
                                  ),
                                  if (data.repliedTo!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(right: 5.w),
                                      child: data.repliedTo!.length
                                          .toString()
                                          .txt(),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                  loading: () {
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ).tap(onTap: () {
            Routemaster.of(context).push('/post/${post.id}');
          });
  }
}
