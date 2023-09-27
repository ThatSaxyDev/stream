// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream/features/base_nav/views/base_nav_view.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/features/posts/widgets/create_post_bottom_sheet.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';

class NavBarWidget extends ConsumerWidget {
  final Nav nav;
  const NavBarWidget({
    Key? key,
    required this.nav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    int indexFromController = ref.watch(baseNavControllerProvider);
    if (nav.index > 2) {
      indexFromController = indexFromController + 1;
    }
    return SizedBox(
      width: 50.w,
      child: Column(
        children: [
          //! ICON
          Icon(
            switch (indexFromController == nav.index && nav.index != 2) {
              true => nav.selectedIcon,
              false => nav.icon,
            },
            color: switch (indexFromController == nav.index && nav.index != 2) {
              true => currentTheme.textTheme.bodyMedium!.color,
              false =>
                currentTheme.textTheme.bodyMedium!.color!.withOpacity(0.4),
            },
          ),

          // //! SPACER
          // 8.4.sbH,
        ],
      ),
    ).tap(
      onTap: () {
        if (nav.index == 0) {
          ref.invalidate(userPostProvider);
        }

        if (nav.index < 2) {
          moveToPage(
            context: context,
            ref: ref,
            index: nav.index,
          );
        }
        if (nav.index == 2) {
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
        }
        if (nav.index > 2) {
          moveToPage(
            context: context,
            ref: ref,
            index: nav.index - 1,
          );
        }
      },
    );
  }
}
