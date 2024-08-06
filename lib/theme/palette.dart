// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream/shared/app_texts.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallete {
  //! from BUNEWS
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color(0xff6A8189); // secondary color
  static const drawerColor = Color(0xff121212);
  static const whiteColor = Colors.white;
  static const brownColor = Color(0xff593C2A);
  static const primaryTeal = Color(0xff057672);
  static const offWhiteTeal = Color(0xfff3f8f8);
  static const primaryPurple = Color(0xff46348C);
  static const tileShadow = Color(0xffC1D1B0);
  static const backButtonGrey = Color(0xffF4F5F5);
  static const orange = Color(0xffD95700);
  static const textGrey = Color(0xff969696);
  static const imagePlaceHolder1 = Color(0xffD9D9D9);
  static var imagePlaceHolder2 = const Color(0xff969696).withOpacity(0.29);
  static const imagePlaceHolder3 = Color(0xffECE9D9);
  static const imagePlaceHolder4 = Color(0xffA7CAE3);
  static const greey = Color(0xffC4C4C4);
  static const thickRed = Color(0xffE41111);
  static const blackTint = Color(0xff121212);
  static const lightbrownColor = Color(0xffB48669);
  static const textGreen = Color(0xff4E6139);
  static const blueColor = Color(0xff034DC6);

  //! ****

  static const textBlack = Color(0xff101828);

  static const borderGrey = Color(0xffD0D5DD);
  static const dotGrey = Color(0xffF2F4F7);
  static const textLighterGrey = Color(0xff667085);

  static const activegreen = Color(0xff039855);
  static const grn = Color(0xff6CE9A6);
  static const grnn = Color(0xff12B76A);
  static const darkgrn = Color(0xff042619);
  static const activegreenBack = Color(0xffECFDF3);
  static const endedRed = Color(0xffB42318);
  static const endedRedBack = Color(0xffFEE4E2);
  static const greyAccent = Color(0xff2D454F);
  static const anothertextBlack = Color(0xff1D2939);
  static const lightBlue = Color(0xffE7F5FB);
  static const newBlack = Color(0xff161C1F);
  static const textWhite = Color(0xffFCFCFD);
  static const downBorderGRey = Color(0xffF4F4F4);
  static const borderRed = Color(0xffF97066);
  static const someNewGrey = Color(0xffB8B8B8);
  static const cream = Color(0xffFFF4ED);
  static const newTextGrey = Color(0xff667084);

  //! for the car condition
  static const carExcellent = Color(0xff00FF00);
  static const carVeryGood = Color(0xff66CCCC);
  static const carGood = Color(0xffFFCC99);
  static const carFair = Color(0xffFF6666);

  //! driving routines
  static const cityDrivingRed = Color(0xffFF3300);
  static const highwayBlue = Color(0xff0066CC);
  static const commutingGrey = Color(0xff666666);
  static const longDistanceTravelGreen = Color(0xff009900);
  static const dailyShortTripsYellow = Color(0xffFFCC00);
  static const businessProfessionalGrey = Color(0xff333333);
  static const weekendLeisurePink = Color(0xffFF6699);

  //! ****

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: AppTexts.appFont,
        ),
    // scaffoldBackgroundColor: blackColor,
    scaffoldBackgroundColor: drawerColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: blueColor,
    // backgroundColor:
    //     drawerColor, // will be used as alternative background color
    canvasColor: greyColor, colorScheme: ColorScheme.fromSwatch(),
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: AppTexts.appFont,
        ),
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: blueColor,
    // backgroundColor: whiteColor,
    // backgroundColor: const Color(0xFFFAFAFA),
    canvasColor: blackColor,
    colorScheme: ColorScheme.fromSwatch(),
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(
          Pallete.darkModeAppTheme,
        ) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
