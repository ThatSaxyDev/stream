import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/base_nav/views/base_nav_view.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/features/posts/widgets/reply_post_bottom_sheet.dart';
import 'package:stream/features/posts/widgets/repost_quote_bottom_sheet.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/nav.dart';
import 'package:stream/utils/widgets/image_loader.dart';
import 'package:timeago/timeago.dart' as timeago;

class ViewsPostCard extends ConsumerWidget {
  final PostModel post;
  const ViewsPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? ownUser = ref.watch(userProvider);
    int indexFromController = ref.watch(baseNavControllerProvider);
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    UserModel? user;

    ref.watch(getUserProvider(post.userUid!)).whenData((value) => user = value);
    if (user == null) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //! image
              CircleAvatar(
                radius: 17.w,
                backgroundImage: NetworkImage(user!.profilePic!),
              ),
              10.sbW,

              //! name
              '@${user!.username!}'.txt(fontWeight: FontWeight.w600),

              const Spacer(),

              //! time
              ...[
                //! time, menu
                timeago.format(post.createdAt!, locale: 'en_short').txt(
                      size: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                7.sbW,
                const Icon(PhosphorIconsBold.dotsThree).tap(
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
                              color: currentTheme.colorScheme.surface,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                                  .textTheme.bodyMedium!.color),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            ref
                                                .read(postControllerProvider
                                                    .notifier)
                                                .deletePost(
                                                    post: post,
                                                    context: context);
                                            goBackk(context);
                                          },
                                          child: 'Delete'
                                              .txt(color: Pallete.thickRed),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ]
            ],
          ),
          10.sbH,

          //! content
          if (post.textContent!.isNotEmpty) ...[
            2.sbH,
            SizedBox(
              width: width(context) * 0.8,
              child: SelectableText(
                post.textContent!,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ).tap(onTap: () {
              Routemaster.of(context).push('/post/${post.id}');
            }),
          ],

          //! image
          if (post.imageUrl!.isNotEmpty) ...[
            10.sbH,
            ImageLoader(
              height: width(context),
              width: width(context),
              imageUrl: post.imageUrl!,
            ).alignCenterLeft(),
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
                    showModalBottomSheet(
                      isScrollControlled: true,
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => Wrap(
                        children: [
                          RepostQuoteBottomSheet(
                            post: post,
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    PhosphorIconsRegular.repeat,
                    color: post.repostedBy!.contains(ownUser!.uid)
                        ? Pallete.activegreen
                        : currentTheme.textTheme.bodyMedium!.color,
                  ),
                ),
                // if (post.repostedBy!.isNotEmpty)
                //   Padding(
                //     padding: EdgeInsets.only(right: 5.w),
                //     child: post.repostedBy!.length.toString().txt(),
                //   ),

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
                  icon: post.likedBy!.contains(ownUser.uid)
                      ? const Icon(
                          PhosphorIconsFill.heart,
                          color: Pallete.thickRed,
                        )
                      : const Icon(PhosphorIconsRegular.heart),
                ),
                // if (post.likedBy!.isNotEmpty)
                //   Padding(
                //     padding: EdgeInsets.only(right: 5.w),
                //     child: post.likedBy!.length.toString().txt(),
                //   ),

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
                  icon: const Icon(PhosphorIconsRegular.chatCentered),
                ),
                // if (post.repliedTo!.isNotEmpty)
                //   Padding(
                //     padding: EdgeInsets.only(right: 5.w),
                //     child: post.repliedTo!.length.toString().txt(),
                //   ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 13.w),
            child: Row(
              children: [
                //! reposts
                switch (post.repostedBy!.isEmpty) {
                  true => const SizedBox.shrink(),
                  false => post.repostedBy!.length == 1
                      ? '${post.repostedBy!.length} repost'.txt(
                          color: currentTheme.textTheme.bodyMedium!.color!
                              .withOpacity(0.4))
                      : '${post.repostedBy!.length} reposts'.txt(
                          color: currentTheme.textTheme.bodyMedium!.color!
                              .withOpacity(0.4))
                },
                10.sbW,

                //! likes
                switch (post.likedBy!.isEmpty) {
                  true => const SizedBox.shrink(),
                  false => post.likedBy!.length == 1
                      ? '${post.likedBy!.length} like'.txt(
                          color: currentTheme.textTheme.bodyMedium!.color!
                              .withOpacity(0.4))
                      : '${post.likedBy!.length} likes'.txt(
                          color: currentTheme.textTheme.bodyMedium!.color!
                              .withOpacity(0.4))
                },
                10.sbW,

                //! replies
                switch (post.repliedTo!.isEmpty) {
                  true => const SizedBox.shrink(),
                  false => post.repliedTo!.length == 1
                      ? '${post.repliedTo!.length} reply'.txt(
                          color: currentTheme.textTheme.bodyMedium!.color!
                              .withOpacity(0.4))
                      : '${post.repliedTo!.length} replies'.txt(
                          color: currentTheme.textTheme.bodyMedium!.color!
                              .withOpacity(0.4))
                },
              ],
            ),
          ),
        ],
      ),
    );
  }
}
