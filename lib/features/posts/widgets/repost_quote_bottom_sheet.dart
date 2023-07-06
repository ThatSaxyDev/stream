import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/features/posts/widgets/quote_bottom_sheet.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/nav.dart';

class RepostQuoteBottomSheet extends ConsumerWidget {
  final PostModel post;
  const RepostQuoteBottomSheet({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? userr = ref.watch(userProvider);
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    return Container(
        height: 100.h,
        width: width(context),
        decoration: BoxDecoration(
          color: currentTheme.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //! repost
            Container(
              height: 40.h,
              width: 120.w,
              decoration: BoxDecoration(
                color:
                    currentTheme.textTheme.bodyMedium!.color!.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  post.repostedBy!.contains(userr!.uid)
                      ? Icon(
                          PhosphorIcons.x,
                          color: Pallete.thickRed,
                          size: 18.sp,
                        )
                      : Icon(
                          PhosphorIcons.repeat,
                          color: currentTheme.textTheme.bodyMedium!.color!,
                          size: 18.sp,
                        ),
                  7.sbW,
                  Text(
                    post.repostedBy!.contains(userr.uid) ? 'Remove' : 'Repost',
                    style: TextStyle(
                      color: post.repostedBy!.contains(userr.uid)
                          ? Pallete.thickRed
                          : currentTheme.textTheme.bodyMedium!.color!,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ).tap(onTap: () {
              goBack(context);
              ref
                  .read(postControllerProvider.notifier)
                  .rePost(context: context, post: post);
            }),
            40.sbW,

            //! quote
            Container(
              height: 40.h,
              width: 120.w,
              decoration: BoxDecoration(
                color:
                    currentTheme.textTheme.bodyMedium!.color!.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.quotes,
                    color: currentTheme.textTheme.bodyMedium!.color!,
                    size: 20.sp,
                  ),
                  7.sbW,
                  Text(
                    'Quote',
                    style: TextStyle(
                      color: currentTheme.textTheme.bodyMedium!.color!,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ).tap(onTap: () {
              goBack(context);
              Timer(const Duration(milliseconds: 200), () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  enableDrag: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => Wrap(
                    children: [
                      QuotePostBottomSheet(
                        post: post,
                      ),
                    ],
                  ),
                );
              });
            }),
          ],
        )));
  }
}
