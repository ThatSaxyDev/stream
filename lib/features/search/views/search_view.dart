// ignore_for_file: deprecated_member_use

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/search/controllers/search_controller.dart';
import 'package:stream/features/search/views/search_delegate.dart';
import 'package:stream/features/search/widgets/search_user_card.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/error_text.dart';
import 'package:stream/utils/loader.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? ownUser = ref.watch(userProvider);
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    AsyncValue<List<UserModel>> allUsersStream = ref.watch(allUsersProvider);
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: currentTheme.backgroundColor,
        foregroundColor: currentTheme.textTheme.bodyMedium!.color,
        elevation: 0,
        centerTitle: false,
        title: 'Search'.txt(
          size: 24.sp,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchUserDelegate(ref),
              );
            },
            icon: const Icon(PhosphorIcons.magnifyingGlass),
          ),
        ],
      ),
      body: allUsersStream.when(
        data: (List<UserModel> allUsers) {
          if (allUsers.isEmpty) {
            return const SizedBox.shrink();
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            padding: EdgeInsets.zero,
            itemCount: allUsers.length,
            itemBuilder: (context, index) {
              UserModel user = allUsers[index];

              if (user.uid == ownUser!.uid) {
                return const SizedBox.shrink();
              }

              return SearchUserCard(user: user);
            },
          );
        },
        error: (error, stackTrace) {
          error.toString().log();
          return const ErrorText(error: 'An error occurred');
        },
        loading: () => Loadinggg(
          height: 40.h,
        ),
      ),
    );
  }
}
