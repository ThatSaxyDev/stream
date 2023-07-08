import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/profile/controllers/profile_controller.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/widgets/button.dart';

import '../../../utils/app_constants.dart';

class SearchUserCard extends ConsumerWidget {
  final UserModel user;
  const SearchUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    UserModel ownUser = ref.watch(userProvider)!;
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! profile pic
              CircleAvatar(
                radius: 18.w,
                backgroundImage: NetworkImage(user.profilePic!),
              ),
              15.sbW,

              //! name. followers
              SizedBox(
                width: 170.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    user.isVerified! != true
                        ? user.username!.txt(
                            size: 15.sp,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Row(
                            children: [
                              user.username!.txt(
                                size: 15.sp,
                                fontWeight: FontWeight.w600,
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
                    1.sbH,
                    user.name!.txt(
                      size: 13.sp,
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: currentTheme.textTheme.bodyMedium!.color!
                          .withOpacity(0.4),
                    ),
                    10.sbH,
                    Row(
                      children: [
                        user.followers!.length.toString().txt(
                              size: 14.sp,
                            ),
                        3.sbW,
                        user.followers!.length == 1
                            ? 'follower'.txt(
                                size: 14.sp,
                                fontWeight: FontWeight.w400,
                              )
                            : 'followers'.txt(
                                size: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          //! button
          TransparentButton(
            height: 30.h,
            width: 100.w,
            text: user.followers!.contains(ownUser.uid)
                ? 'Following'
                : user.following!.contains(ownUser.uid)
                    ? 'Follow back'
                    : 'Follow',
            textColor: user.followers!.contains(ownUser.uid)
                ? currentTheme.textTheme.bodyMedium!.color!.withOpacity(0.5)
                : null,
            color: currentTheme.textTheme.bodyMedium!.color!.withOpacity(0.5),
            onTap: () {
              ref
                  .read(userProfileControllerProvider.notifier)
                  .followUser(userToFollow: user);
            },
          ),
        ],
      ),
    ).tap(onTap: () {
      Routemaster.of(context).push('/profile/${user.uid}');
    });
  }
}
