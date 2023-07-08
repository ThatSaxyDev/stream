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
import 'package:stream/features/profile/controllers/profile_controller.dart';
import 'package:stream/features/profile/widgets/edit_profile_bottom_sheet.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/shared/app_routes.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/nav.dart';
import 'package:stream/utils/widgets/button.dart';
import 'package:tabbed_sliverlist/tabbed_sliverlist.dart';

class OtherUserProfileView extends ConsumerWidget {
  final String userId;
  const OtherUserProfileView({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData currentTheme = ref.watch(themeNotifierProvider);

    UserModel ownUser = ref.watch(userProvider)!;
    AsyncValue<List<PostModel>> userProfilePostsStream =
        ref.watch(otherUserProfilePostProvider(userId));

    List<PostModel> userProfilePosts = [];

    userProfilePostsStream.whenData((value) => userProfilePosts = value);

    UserModel? user;

    ref.watch(getUserProvider(userId)).whenData((value) => user = value);
    if (user == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: TabbedList(
        tabLength: 2,
        sliverTabBar: SliverTabBar(
            elevation: 0,
            // actions: [
            //   IconButton(
            //     highlightColor: Colors.transparent,
            //     splashColor: Colors.transparent,
            //     onPressed: () {},
            //     icon: const Icon(PhosphorIcons.listDashes),
            //   ),
            // ],
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
                        CircleAvatar(
                          radius: 35.w,
                          backgroundImage: NetworkImage(user!.profilePic!),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            user!.name!.txt(
                              size: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            7.sbH,
                            user!.isVerified! != true
                                ? '@${user!.username!}'
                                    .replaceAll(' ', '')
                                    .toLowerCase()
                                    .txt(
                                      size: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    )
                                : Row(
                                    children: [
                                      '@${user!.username!}'
                                          .replaceAll(' ', '')
                                          .toLowerCase()
                                          .txt(
                                            size: 14.sp,
                                            fontWeight: FontWeight.w700,
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
                      ],
                    ),
                    15.sbH,
                    //! bio
                    SizedBox(
                      width: width(context),
                      child: Text(
                        user!.banner!,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    13.sbH,
                    //!
                    //! folowers , following
                    Row(
                      children: [
                        user!.followers!.length.toString().txt(
                              size: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: currentTheme.textTheme.bodyMedium!.color!
                                  .withOpacity(0.9),
                            ),
                        3.sbW,
                        user!.followers!.length == 1
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
                        user!.following!.length.toString().txt(
                              size: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: currentTheme.textTheme.bodyMedium!.color!
                                  .withOpacity(0.9),
                            ),
                        3.sbW,
                        user!.following!.length == 1
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
                        user!.link!.txt(
                          size: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: currentTheme.textTheme.bodyMedium!.color!
                              .withOpacity(0.6),
                        ),
                      ],
                    ),
                    15.sbH,

                    //! follow
                    TransparentButton(
                      onTap: () {
                        ref
                            .read(userProfileControllerProvider.notifier)
                            .followUser(userToFollow: user!);
                      },
                      color: currentTheme.textTheme.bodyMedium!.color!
                          .withOpacity(0.5),
                      text: user!.followers!.contains(ownUser.uid)
                          ? 'Following'
                          : user!.following!.contains(ownUser.uid)
                              ? 'Follow back'
                              : 'Follow',
                    ),
                  ],
                ),
              ),
            ),
            expandedHeight: 320.h,
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
                              Icon(
                                PhosphorIcons.placeholderBold,
                                size: 60.sp,
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
        ],
      ),
    );
  }
}
