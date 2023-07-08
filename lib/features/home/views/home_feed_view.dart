import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/home/widgets/post_card.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/features/posts/widgets/feed_quote_card.dart';
import 'package:stream/features/posts/widgets/feed_reply_post_card.dart';
import 'package:stream/features/posts/widgets/repost_card.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/repost_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/loader.dart';

class HomeFeedView extends ConsumerStatefulWidget {
  const HomeFeedView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeFeedViewState();
}

class _HomeFeedViewState extends ConsumerState<HomeFeedView> {
  List<RepostModel>? reposts;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> isListAtTop = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<PostModel>> userPostsStream = ref.watch(userPostProvider);
    AsyncValue<List<RepostModel>> rePostsStream =
        ref.watch(fetchRepostsFromFollowingAndUserProvider);
    rePostsStream.when(
      data: (data) {
        reposts = data;
      },
      error: (error, stackTrace) {
        error.toString().log();
      },
      loading: () {},
    );
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    return SizedBox(
      height: height(context),
      width: width(context),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            // Check if the list is at the top
            if (notification.metrics.pixels == 0) {
              Timer(const Duration(milliseconds: 1000), () {
                isListAtTop.value = false;
              });
            } else {
              isListAtTop.value = true;
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Column(
            children: [
              //! header
              60.sbH,
              ValueListenableBuilder(
                valueListenable: isListAtTop,
                builder: (context, value, child) => isListAtTop.value == true
                    ? Loadinggg(
                        height: 25.h,
                      )
                    : Image.asset(
                        currentTheme == Pallete.lightModeAppTheme
                            ? 'logolight'.jpg
                            : 'logodark'.jpg,
                        height: 25.h,
                      ).tap(onTap: () {}),
              ),

              10.sbH,

              if (reposts != null)
                ...List.generate(reposts!.length, (index) {
                  PostModel? post;
                  ref
                      .watch(getPostByIdProvider(reposts![index].postId!))
                      .whenData((value) => post = value);

                  if (post != null) {
                    return RepostPostCard(
                      repost: reposts![index],
                      post: post!,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

              userPostsStream.when(
                data: (List<PostModel> posts) {
                  posts.length.toString();
                  if (posts.isEmpty) {
                    return Column(
                      children: [
                        250.sbH,
                        'There are no posts'.txt(
                          size: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: List.generate(
                      posts.length,
                      (index) {
                        PostModel post = posts[index];
                        if (post.replyingPostId!.isNotEmpty) {
                          return FeedReplyPostCard(post: post);
                        } else if (post.quotingPostId!.isNotEmpty) {
                          return FeedQuotePostCard(post: post);
                        }
                        return PostCard(post: post);
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  error.toString().log();
                  return Column(
                    children: [
                      250.sbH,
                      'An error occurred'.txt(
                        size: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  );
                },
                loading: () => Column(
                  children: [
                    250.sbH,
                    SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: const CircularProgressIndicator.adaptive(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
