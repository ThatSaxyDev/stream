import 'package:flutter/material.dart';
import 'package:stream/utils/keyboard_utils.dart';
import 'package:routemaster/routemaster.dart';

// void goBack(BuildContext context) {
//   killKeyboard(context);
//   Navigator.of(context).pop();
// }

void goBack(BuildContext context) {
  killKeyboard(context);
  Routemaster.of(context).pop();
}

//! nav function
void goTo(BuildContext context, Widget view) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: ((context) {
        return view;
      }),
    ),
  );
}
