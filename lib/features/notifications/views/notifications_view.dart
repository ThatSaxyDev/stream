// ignore_for_file: deprecated_member_use

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';

class NotificationsView extends ConsumerWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? ownUser = ref.watch(userProvider);
    ThemeData currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: currentTheme.backgroundColor,
        foregroundColor: currentTheme.textTheme.bodyMedium!.color,
        elevation: 0,
        centerTitle: false,
        title: 'Notifications'.txt(
          size: 24.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
