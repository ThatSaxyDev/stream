// ignore_for_file: deprecated_member_use


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/widgets/image_loader.dart';

class ReplyPostCard extends ConsumerWidget {
  final PostModel post;
  const ReplyPostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    UserModel? user;

    ref.watch(getUserProvider(post.userUid!)).whenData((value) => user = value);
    if (user == null) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: width(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 15.w,
                backgroundImage: NetworkImage(user!.profilePic!),
              ),
              20.sbH,
              Container(
                width: 0.5,
                height: 40.h,
                color: currentTheme.textTheme.bodyMedium!.color!,
                // height: double.maxFinite,
              ),
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
                ],
              ),

              //! content
              if (post.textContent!.isNotEmpty) ...[
                2.sbH,
                SizedBox(
                  width: width(context) * 0.8,
                  child: SelectableText(
                    post.textContent!,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ],

              //! image
              if (post.imageUrl!.isNotEmpty) ...[
                10.sbH,
                ImageLoader(
                  height: 120.h,
                  width: 110.w,
                  imageUrl: post.imageUrl!,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
