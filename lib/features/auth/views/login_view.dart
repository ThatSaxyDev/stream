// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass/glass.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/loader.dart';
import 'package:stream/utils/widgets/button.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    final currentTheme = ref.watch(themeNotifierProvider);
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: isLoading
            ? Loadinggg(
                height: 40.h,
              )
            : Column(
                children: [
                  150.sbH,
                  Image.asset(
                    currentTheme == Pallete.lightModeAppTheme
                        ? 'logolight'.jpg
                        : 'logodark'.jpg,
                    height: 100.h,
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(1.0, -1.0, 1.0),
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        currentTheme == Pallete.lightModeAppTheme
                            ? 'logolight'.jpg
                            : 'logodark'.jpg,
                        height: 100.h,
                      ).asGlass(),
                    ),
                  ),
                  170.sbH,
                  const GButton(),
                  20.sbH,

                  //! apple
                  if (Platform.isIOS) const AppleButton()
                ],
              ),
      ),
    );
  }
}
