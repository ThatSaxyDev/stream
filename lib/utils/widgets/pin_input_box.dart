import 'package:stream/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class PinInputBox extends StatelessWidget {
  final void Function(String)? onCompleted;
  final TextEditingController? controller;
  const PinInputBox({
    Key? key,
    this.onCompleted,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 4,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // obscuringCharacter: '*',
      obscureText: false,
      useNativeKeyboard: true,
      defaultPinTheme: PinTheme(
        width: 55.h,
        height: 57.h,
        textStyle: TextStyle(
          fontSize: 32.sp,
          color: Pallete.textBlack,
          fontWeight: FontWeight.w900,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Pallete.greyColor),
          color: Pallete.whiteColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 51.h,
        height: 57.h,
        textStyle: TextStyle(
          fontSize: 32.sp,
          color: Pallete.orange,
          fontWeight: FontWeight.w900,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Pallete.orange),
          color: Pallete.whiteColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 51.h,
        height: 57.h,
        textStyle: TextStyle(
          fontSize: 32.sp,
          color: Pallete.orange,
          fontWeight: FontWeight.w900,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Pallete.greyColor),
          color: Pallete.whiteColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      controller: controller,
      onCompleted: onCompleted,
    );
  }
}
