import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/search/controllers/search_controller.dart';
import 'package:stream/features/search/widgets/search_user_card.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/error_text.dart';
import 'package:stream/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchUserDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchUserDelegate(this.ref);
  @override
  List<Widget>? buildActions(BuildContext context) {
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          PhosphorIcons.x,
          color: currentTheme.textTheme.bodyMedium!.color,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    UserModel? ownUser = ref.watch(userProvider);
    return ref.watch(searchUsersProvider(query)).when(
          data: (List<UserModel> allUsers) {
            // if (allUsers.isEmpty) {
            //   return const SizedBox.shrink();
            // }

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
          loading: () => const Loadinggg(),
        );
  }
}
