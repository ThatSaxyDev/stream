import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stream/features/auth/views/login_view.dart';
import 'package:stream/features/base_nav/views/base_nav_view.dart';
import 'package:stream/features/settings/views/settings_view.dart';
import 'package:stream/shared/app_routes.dart';

final loggedOutRoute = RouteMap(
    routes: {AppRoutes.base: (_) => const MaterialPage(child: LoginView())});

final loggedInRoute = RouteMap(
  routes: {
    AppRoutes.base: (_) => const MaterialPage(
          child: BaseNavWrapper(),
        ),
    AppRoutes.settings: (_) => const MaterialPage(
          child: SettingsView(),
        ),
    // '/approval-status': (_) => const MaterialPage(
    //       child: AppprovalStatusView(),
    //     ),
    // '/add-post/:from': (routeData) => MaterialPage(
    //       child: AddPostView(
    //         isFromCommunity: routeData.pathParameters['from']!,
    //       ),
    //     ),
    // '/bookmarks': (routeData) => const MaterialPage(
    //       child: BookmarksView(),
    //     ),
    // // '/create-community': (_) => const MaterialPage(
    // //       child: CreateCommunityScreen(),
    // //     ),
    // '/com/:name': (route) => MaterialPage(
    //       child: CommnunityProfileView(
    //         name: route.pathParameters['name']!,
    //       ),
    //     ),
    // '/com/:name/community-settings/:name': (routeDate) => MaterialPage(
    //       child: CommunitySettingsView(
    //         name: routeDate.pathParameters['name']!,
    //       ),
    //     ),
    // '/com/:name/community-settings/:name/edit-community/:name': (routeData) =>
    //     MaterialPage(
    //       child: EditCommunityView(
    //         name: routeData.pathParameters['name']!,
    //       ),
    //     ),
    // '/com/:name/community-settings/:name/add-mods/:name': (routeData) =>
    //     MaterialPage(
    //       child: AddModsView(
    //         name: routeData.pathParameters['name']!,
    //       ),
    //     ),
    // '/image/:url': (routeData) => MaterialPage(
    //       child: ImageView(
    //         imageUrl: routeData.pathParameters['url']!,
    //       ),
    //     ),
    // '/edit-profile': (routeData) => const MaterialPage(
    //       child: EditProfileView(),
    //     ),
  },
);
