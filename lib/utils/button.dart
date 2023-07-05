// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:stream/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class BButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final void Function()? onTap;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final Widget? item;
  final String? text;
  final bool isText;
  final EdgeInsetsGeometry? padding;
  const BButton({
    Key? key,
    this.height,
    this.width,
    this.radius,
    required this.onTap,
    this.color,
    this.borderColor,
    this.textColor,
    this.item,
    this.text,
    this.isText = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: borderColor ?? Colors.transparent,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 8.r),
            ),
          ),
          padding: padding ?? EdgeInsets.zero,
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: color ?? Pallete.orange,
        ),
        child: Center(
          child: isText == true
              ? Text(
                  text ?? '',
                  style: TextStyle(
                    color: textColor ?? Pallete.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : item,
        ),
      ),
    );
  }
}

class TransparentButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final void Function()? onTap;
  final Color? color;
  final Widget? item;
  final String? text;
  final bool isText;
  final Color? backgroundColor;
  final Color? textColor;
  const TransparentButton({
    Key? key,
    this.height,
    this.width,
    this.radius,
    required this.onTap,
    this.color,
    this.item,
    this.text,
    this.isText = true,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: color ?? Pallete.greey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 8.r),
            ),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor ?? Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: isText == true
              ? Text(
                  text ?? '',
                  style: TextStyle(
                    color: textColor ?? Pallete.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : item,
        ),
      ),
    );
  }
}

// class GButton extends ConsumerWidget {
//   // final double height;
//   // final double width;
//   final double padding;
//   // final double radius;
//   // final void Function()? onTap;

//   final Widget item;
//   final bool isFromLogin;
//   const GButton({
//     Key? key,
//     // required this.height,
//     // required this.width,
//     this.padding = 30,
//     this.isFromLogin = true,
//     // required this.radius,
//     // required this.onTap,

//     required this.item,
//   }) : super(key: key);

//   void signInWithGoogle(BuildContext context, WidgetRef ref) {
//     ref.read(authControllerProvider.notifier).signInWithGoogle(context);
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentTheme = ref.watch(themeNotifierProvider);
//     return SizedBox(
//       height: 50.h,
//       // width: width,
//       child: ElevatedButton(
//         onPressed: () => signInWithGoogle(context, ref),
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             side: BorderSide(
//               width: 0.5.w
//             ),
//             borderRadius: BorderRadius.all(
//               Radius.circular(35.r),
//             ),
//           ),
//           elevation: 0,
//           shadowColor: Colors.transparent,
//           backgroundColor: currentTheme.backgroundColor,
//           padding: EdgeInsets.symmetric(horizontal: padding),
//         ),
//         child: Center(
//           child: item,
//         ),
//       ),
//     );
//   }
// }

class TTransparentButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? padding;
  final void Function()? onTap;
  final Color color;
  final Widget child;
  const TTransparentButton({
    Key? key,
    this.height,
    this.width,
    this.padding,
    required this.onTap,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33.3.h,
      width: 40.w,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: color,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.r),
              ),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.symmetric(
              vertical: padding ?? 0,
            )),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
