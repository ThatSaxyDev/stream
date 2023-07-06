import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream/features/home/widgets/post_card.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';


class HomeFeedView extends ConsumerWidget {
  const HomeFeedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<PostModel>> userPostsStream = ref.watch(userPostProvider);
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    return SizedBox(
      height: height(context),
      width: width(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //! header
            60.sbH,
            'Usetream'.txt(),
            20.sbH,

            userPostsStream.when(
              data: (List<PostModel> posts) {
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
    );
  }
}
