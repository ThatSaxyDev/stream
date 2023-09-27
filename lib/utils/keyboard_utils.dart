import 'package:flutter/material.dart';

killKeyboard(BuildContext context) {
  if (FocusScope.of(context).isFirstFocus) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

dropKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
