// ignore_for_file: deprecated_member_use

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/features/home/widgets/post_card.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/features/posts/views/widgets/views_post_card.dart';
import 'package:stream/features/posts/widgets/reply_post_bottom_sheet.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/loader.dart';
import 'package:stream/utils/widgets/click_button.dart';

class PostView extends ConsumerWidget {
  final String postId;
  const PostView({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    final postStream = ref.watch(getPostByIdProvider(postId));
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: 'Stream'.txt(size: 16.sp, fontWeight: FontWeight.w500),
      ),
      body: postStream.when(
        data: (PostModel postt) {
          return SizedBox.expand(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: Column(
                    children: [
                      //! post
                      ViewsPostCard(post: postt),

                      //! replies
                      if (postt.repliedTo!.isNotEmpty)
                        ...List.generate(
                          postt.repliedTo!.length,
                          (index) {
                            PostModel? reply;
                            ref
                                .watch(getPostByIdProvider(
                                    postt.repliedTo![index]))
                                .whenData((value) => reply = value);

                            if (reply == null) {
                              return const SizedBox.shrink();
                            } else {
                              return PostCard(post: reply!);
                            }
                          },
                        ),
                    ],
                  ),
                ),

                //! reply
                Positioned(
                    bottom: 40.h,
                    right: 40.w,
                    child: ClickButton(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          enableDrag: false,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => Wrap(
                            children: [
                              ReplyPostBottomSheet(post: postt),
                            ],
                          ),
                        );
                      },
                      height: 50.h,
                      width: 60.w,
                      child: const Icon(PhosphorIcons.chatCenteredBold),
                    ))
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          error.toString().log();
          return Center(
            child: 'An error occured'
                .txt(size: 16.sp, fontWeight: FontWeight.w600),
          );
        },
        loading: () => Center(
          child: Loadinggg(
            height: 40.h,
          ),
        ),
      ),
    );
  }
}
