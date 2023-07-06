import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
      backgroundColor: currentTheme.colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: isLoading
            ? const Loader()
            : Column(
                children: [
                  150.sbH,

                  // Container(
                  //   padding: 20.padH,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(40.r),
                  //     image: DecorationImage(
                  //         image: AssetImage('log'.png), fit: BoxFit.cover),
                  //   ),
                  //   height: 200.h,
                  //   width: 200.w,
                  // ),
                  Icon(
                    PhosphorIcons.cookingPot,
                    size: 200.sp,
                  ),
                  170.sbH,
                  const GButton(),
                ],
              ),
      ),
    );
  }
}
