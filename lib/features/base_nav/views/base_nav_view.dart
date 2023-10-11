// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/features/base_nav/widgets/nav_bar_widget.dart';
import 'package:stream/features/home/views/home_feed_view.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/widgets/image_loader.dart';
import 'package:stream/utils/widgets/image_overlay.dart';

part '../views/base_nav_view.controller.dart';

class BaseNavWrapper extends ConsumerWidget {
  const BaseNavWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromController = ref.watch(baseNavControllerProvider);
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    String? imageOverlay = ref.watch(imageOverlayControllerProvider);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: currentTheme.backgroundColor,
          // pages
          body: pages[indexFromController],

          // nav bar
          bottomNavigationBar: Material(
            elevation: 5,
            child: Container(
              color: currentTheme.backgroundColor,
              padding: EdgeInsets.only(top: 17.h, left: 17.w, right: 17.w),
              height: 80.h,
              width: width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  nav.length,
                  (index) => NavBarWidget(nav: nav[index]),
                ),
              ),
            ),
          ),
        ),
        if (imageOverlay != null) ImageOverLay(imageUrl: imageOverlay)
      ],
    );
  }
}
