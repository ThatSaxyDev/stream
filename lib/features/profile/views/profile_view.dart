// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/base_nav/views/base_nav_view.dart';
import 'package:stream/features/home/widgets/post_card.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/features/posts/widgets/create_post_bottom_sheet.dart';
import 'package:stream/features/posts/widgets/feed_quote_card.dart';
import 'package:stream/features/posts/widgets/feed_reply_post_card.dart';
import 'package:stream/features/profile/widgets/edit_profile_bottom_sheet.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/shared/app_routes.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/loader.dart';
import 'package:stream/utils/nav.dart';
import 'package:tabbed_sliverlist/tabbed_sliverlist.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData currentTheme = ref.watch(themeNotifierProvider);

    UserModel user = ref.watch(userProvider)!;
    AsyncValue<List<PostModel>> userProfilePostsStream =
        ref.watch(userProfilePostProvider);
    AsyncValue<List<PostModel>> userLikedPostsStream =
        ref.watch(getUsersLikedPostsProvider);
    List<PostModel> userProfilePosts = [];
    List<PostModel> userLikedPosts = [];
    userProfilePostsStream.whenData((value) => userProfilePosts = value);
    userLikedPostsStream.whenData((value) => userLikedPosts = value);

    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: TabbedList(
        tabLength: 3,
        sliverTabBar: SliverTabBar(
            elevation: 0,
            actions: [
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () =>
                    goTo(context: context, route: AppRoutes.settings),
                icon: const Icon(PhosphorIcons.listDashes),
              ),
            ],
            flexibleSpace: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 120.h),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //! image
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 35.w,
                              backgroundImage: NetworkImage(user.profilePic!),
                            ),
                            10.sbW,
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  enableDrag: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => const Wrap(
                                    children: [
                                      EditProfileBottomSheet(),
                                    ],
                                  ),
                                );
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: const Icon(PhosphorIcons.eraser),
                            )
                          ],
                        ),

                        SizedBox(
                          width: 200.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              formatNameString(user.name!).txt(
                                size: 20.sp,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                              ),
                              7.sbH,
                              user.isVerified! != true
                                  ? '@${user.username!}'.txt(
                                      size: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        '@${user.username!}'.txt(
                                          size: 14.sp,
                                          fontWeight: FontWeight.w700,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    15.sbH,
                    //! bio
                    SizedBox(
                      width: width(context),
                      child: user.banner!.isNotEmpty
                          ? Text(
                              user.banner!,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : 'Add bio +'
                              .txt(
                              size: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: currentTheme.textTheme.bodyMedium!.color!
                                  .withOpacity(0.6),
                            )
                              .tap(onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                enableDrag: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => const Wrap(
                                  children: [
                                    EditProfileBottomSheet(),
                                  ],
                                ),
                              );
                            }),
                    ),
                    13.sbH,
                    //!
                    //! folowers , following
                    Row(
                      children: [
                        user.followers!.length.toString().txt(
                              size: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: currentTheme.textTheme.bodyMedium!.color!
                                  .withOpacity(0.9),
                            ),
                        3.sbW,
                        user.followers!.length == 1
                            ? 'follower'.txt(
                                size: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: currentTheme.textTheme.bodyMedium!.color!
                                    .withOpacity(0.6),
                              )
                            : 'followers'.txt(
                                size: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: currentTheme.textTheme.bodyMedium!.color!
                                    .withOpacity(0.6),
                              ),
                        10.sbW,
                        user.following!.length.toString().txt(
                              size: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: currentTheme.textTheme.bodyMedium!.color!
                                  .withOpacity(0.9),
                            ),
                        3.sbW,
                        user.following!.length == 1
                            ? 'following'.txt(
                                size: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: currentTheme.textTheme.bodyMedium!.color!
                                    .withOpacity(0.6),
                              )
                            : 'following'.txt(
                                size: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: currentTheme.textTheme.bodyMedium!.color!
                                    .withOpacity(0.6),
                              ),
                        10.sbW,
                        Icon(
                          PhosphorIcons.link,
                          size: 14.sp,
                        ),
                        5.sbW,
                        user.link!.isNotEmpty
                            ? SizedBox(
                                width: 150.w,
                                child: user.link!.txt(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  size: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: currentTheme
                                      .textTheme.bodyMedium!.color!
                                      .withOpacity(0.6),
                                ),
                              )
                            : 'Add link'
                                .txt(
                                size: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: currentTheme.textTheme.bodyMedium!.color!
                                    .withOpacity(0.6),
                              )
                                .tap(onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  enableDrag: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => const Wrap(
                                    children: [
                                      EditProfileBottomSheet(),
                                    ],
                                  ),
                                );
                              }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            expandedHeight: 270.h,
            tabBar: TabBar(
              indicatorColor: currentTheme.textTheme.bodyMedium!.color,
              labelColor: currentTheme.textTheme.bodyMedium!.color,
              tabs: const [
                Tab(
                  text: 'Stream',
                ),
                Tab(
                  text: 'Replies',
                ),
                Tab(
                  text: 'Likes',
                ),
              ],
            )),
        tabLists: [
          //! streams
          userProfilePosts.isEmpty
              ? TabListBuilder(
                  uniquePageKey: 'page1a',
                  length: 1,
                  builder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 150.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIcons.pen,
                                size: 60.sp,
                              ).tap(onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  enableDrag: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => const Wrap(
                                    children: [
                                      CreatePostBottomSheet(),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                          20.sbH,
                          'You have no posts'.txt(
                            size: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    );
                  },
                )
              : TabListBuilder(
                  uniquePageKey: 'page1b',
                  length: userProfilePosts.length,
                  builder: (BuildContext context, int index) {
                    PostModel post = userProfilePosts[index];
                    if (userProfilePosts.isEmpty) {
                      return 'empty'.txt();
                    }
                    if (post.replyingPostId!.isNotEmpty) {
                      return FeedReplyPostCard(post: post);
                    } else if (post.quotingPostId!.isNotEmpty) {
                      return FeedQuotePostCard(post: post);
                    } else {
                      return PostCard(post: post);
                    }
                  },
                ),

          //! replies
          userProfilePosts.isEmpty
              ? TabListBuilder(
                  uniquePageKey: 'page2a',
                  length: 1,
                  builder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 150.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Loadinggg(
                                height: 50.h,
                                duration: 5000,
                              ).tap(onTap: () {
                                moveToPage(
                                    context: context, ref: ref, index: 0);
                              }),
                            ],
                          ),
                          20.sbH,
                          'You have no replies'.txt(
                            size: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    );
                  },
                )
              : TabListBuilder(
                  uniquePageKey: 'page2b',
                  length: userProfilePosts.length,
                  builder: (BuildContext context, int index) {
                    PostModel post = userProfilePosts[index];

                    if (post.replyingPostId!.isNotEmpty) {
                      return FeedReplyPostCard(post: post);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),

          //! likes
          userLikedPosts.isEmpty
              ? TabListBuilder(
                  uniquePageKey: 'page3a',
                  length: 1,
                  builder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 150.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Loadinggg(
                                height: 50.h,
                                duration: 5000,
                              ).tap(onTap: () {
                                moveToPage(
                                    context: context, ref: ref, index: 0);
                              }),
                            ],
                          ),
                          20.sbH,
                          'You have no liked posts'.txt(
                            size: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    );
                  },
                )
              : TabListBuilder(
                  uniquePageKey: 'page3b',
                  length: userLikedPosts.length,
                  builder: (BuildContext context, int index) {
                    PostModel post = userLikedPosts[index];
                    if (userLikedPosts.isEmpty) {
                      return 'empty'.txt();
                    }
                    if (post.replyingPostId!.isNotEmpty) {
                      return FeedReplyPostCard(post: post);
                    } else if (post.quotingPostId!.isNotEmpty) {
                      return FeedQuotePostCard(post: post);
                    } else {
                      return PostCard(post: post);
                    }
                  },
                ),
        ],
      ),
    );
  }
}

String formatNameString(String input) {
  List<String> words = input.split(' ');

  if (words.length >= 3) {
    words[2] = '${words[2][0].toUpperCase()}.';
    words = words.sublist(0, 3);
  }

  return words.join(' ');
}
