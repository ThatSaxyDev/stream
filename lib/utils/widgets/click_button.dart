// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:stream/theme/palette.dart';

class ClickButton extends ConsumerStatefulWidget {
  final void Function()? onTap;
  final double? width;
  final double? height;
  final String? text;
  final bool? isActive;
  final bool? isText;
  final Widget? child;
  const ClickButton({
    Key? key,
    this.onTap,
    this.width,
    this.height,
    this.text,
    this.isActive = true,
    this.isText,
    this.child,
  }) : super(key: key);

  @override
  ConsumerState<ClickButton> createState() => _ClickButtonState();
}

class _ClickButtonState extends ConsumerState<ClickButton> {
  final ValueNotifier<bool> clicked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);
    return ValueListenableBuilder(
      valueListenable: clicked,
      child: const SizedBox.shrink(),
      builder: (context, value, child) {
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (widget.isActive == true) {
              clicked.value = true;
              Timer(const Duration(milliseconds: 100), () {
                clicked.value = false;
                widget.onTap?.call();
              });
            }
          },
          child: SizedBox(
            height: 70.h,
            width: widget.width ?? double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: clicked.value == true
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
                  child: Container(
                    height: 68.h,
                    width: widget.width ?? double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: currentTheme.drawerTheme.backgroundColor,
                      border: Border.all(
                        color: currentTheme.textTheme.bodyMedium!.color!,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: currentTheme.textTheme.bodyMedium!.color!,
                          offset: clicked.value == true
                              ? const Offset(0, 0)
                              : Offset(0, 5.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: widget.isText == true
                          ? Text(
                              widget.text!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : widget.child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
