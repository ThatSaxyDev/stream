// ignore_for_file: deprecated_member_use

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/widgets/image_loader.dart';

class QuotingPostCard extends ConsumerWidget {
  final PostModel post;
  const QuotingPostCard({
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
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        border: Border.all(
            color: currentTheme.textTheme.bodyMedium!.color!.withOpacity(0.3),
            width: 0.5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 7.w,
                    backgroundImage: NetworkImage(user!.profilePic!),
                  ),
                  7.sbW,
                  //! user name

                  user!.isVerified! != true
                      ? '@${user!.name!}'.toLowerCase().txt(
                            size: 14.sp,
                            fontWeight: FontWeight.w600,
                          )
                      : Row(
                          children: [
                            '@${user!.name!}'.toLowerCase().txt(
                                  size: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                            7.sbW,
                            Icon(
                              Icons.whatshot_sharp,
                              size: 14.sp,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                ],
              ),
            ],
          ),

          //! content
          if (post.textContent!.isNotEmpty) ...[
            10.sbH,
            SizedBox(
              width: width(context) * 0.7,
              child: SelectableText(
                post.textContent!,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
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
    );
  }
}
