import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream/firebase_options.dart';
import 'package:stream/list_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: UsetreamApp()));
}

class UsetreamApp extends StatelessWidget {
  const UsetreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Payscore',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
                useMaterial3: true,
              ),
              home: const ListTest(),
            );
          },
        );
      },
    );
  }
}
