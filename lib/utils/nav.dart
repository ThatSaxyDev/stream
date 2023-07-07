import 'package:flutter/material.dart';
import 'package:stream/utils/keyboard_utils.dart';
import 'package:routemaster/routemaster.dart';

void goBackk(BuildContext context) {
  // killKeyboard(context);
  Navigator.of(context).pop();
}

void goBack(BuildContext context) {
  killKeyboard(context);
  Routemaster.of(context).pop();
}

void goTo({
  required BuildContext context,
  required String route,
}) {
  Routemaster.of(context).push(route);
}
