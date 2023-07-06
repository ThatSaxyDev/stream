import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/firebase_options.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/router.dart';
import 'package:stream/shared/app_texts.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/error_text.dart';
import 'package:stream/utils/loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: UsetreamApp()));
}

class UsetreamApp extends ConsumerStatefulWidget {
  const UsetreamApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsetreamAppState();
}

class _UsetreamAppState extends ConsumerState<UsetreamApp> {
  UserModel? userModel;

  void getData({required WidgetRef ref, required User data}) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(uid: data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (User? data) => ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: false,
              builder: (context, child) {
                return Builder(builder: (context) {
                  return MaterialApp.router(
                    title: AppTexts.appName,
                    debugShowCheckedModeBanner: false,
                    theme: ref.watch(themeNotifierProvider),
                    routerDelegate:
                        RoutemasterDelegate(routesBuilder: (context) {
                      if (data != null) {
                        getData(ref: ref, data: data);
                        if (userModel != null) {
                          return loggedInRoute;
                        }
                      }
                      return loggedOutRoute;
                    }),
                    routeInformationParser: const RoutemasterParser(),
                  );
                });
              }),
          error: (error, stactrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
