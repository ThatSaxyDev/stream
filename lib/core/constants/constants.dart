import 'package:flutter/material.dart';

class Constants {
  static const bannerDefault =
      'https://umis.babcock.edu.ng/babcock/assets/landing/images/bu_logo_main_white_bg.jpg';
  static const avatarDefault =
      'https://freesvg.org/img/abstract-user-flat-4.png';
  static const communityAvatarDefault =
      'https://mpng.subpng.com/20180426/ovq/kisspng-multi-user-encapsulated-postscript-users-group-co-5ae16d22590853.6022972915247229783647.jpg';

  // static const tabWidgets = [
  //   FeedScreen(),
  //   AddPostScreen(),
  // ];

  static const IconData up =
      IconData(0xe800, fontFamily: 'MyFlutterApp', fontPackage: null);
  static const IconData down =
      IconData(0xe801, fontFamily: 'MyFlutterApp', fontPackage: null);

  static const awardsPath = 'lib/assets/images';

  static const awards = {
    'awesomeAns': '${Constants.awardsPath}/awesomeanswer.png',
    'gold': '${Constants.awardsPath}/gold.png',
    'platinum': '${Constants.awardsPath}/platinum.png',
    'helpful': '${Constants.awardsPath}/helpful.png',
    'plusone': '${Constants.awardsPath}/plusone.png',
    'rocket': '${Constants.awardsPath}/rocket.png',
    'thankyou': '${Constants.awardsPath}/thankyou.png',
    'til': '${Constants.awardsPath}/til.png',
  };
}
