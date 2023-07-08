// ignore_for_file: deprecated_member_use

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/nav.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData currentTheme = ref.watch(themeNotifierProvider);

    UserModel user = ref.watch(userProvider)!;

    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: currentTheme.backgroundColor,
        title: 'Settings'.txt(
          size: 16.sp,
          fontWeight: FontWeight.w600,
          color: currentTheme.textTheme.bodyMedium!.color,
        ),
      ),
      body: Padding(
        padding: 10.padH,
        child: Column(
          children: [
            //! dark theme
            ListTile(
              leading: Icon(
                PhosphorIcons.moonFill,
                color: currentTheme.textTheme.bodyMedium!.color,
              ),
              title: 'Dark theme'.txt(size: 16.sp),
              trailing: Switch.adaptive(
                value: ref.watch(themeNotifierProvider.notifier).mode ==
                    ThemeMode.dark,
                onChanged: (val) {
                  ref.read(themeNotifierProvider.notifier).toggleTheme();
                },
              ),
            ),

            //! log out
            ListTile(
              onTap: () {
                goBack(context);
                ref.read(authControllerProvider.notifier).logOut();
              },
              leading: const Icon(
                PhosphorIcons.signOutBold,
                color: Pallete.thickRed,
              ),
              title: 'Log out'.txt(size: 16.sp, color: Pallete.thickRed),
            ),
          ],
        ),
      ),
    );
  }
}
