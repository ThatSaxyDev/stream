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
            height: widget.height ?? 70.h,
            width: widget.width ?? double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: clicked.value == true
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
                  child: Container(
                    height: widget.height == null ? 68.h : (widget.height! - 2),
                    width: widget.width ?? double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: widget.isActive == true
                          ? currentTheme.drawerTheme.backgroundColor
                          : currentTheme.drawerTheme.backgroundColor!
                              .withOpacity(0.3),
                      border: Border.all(
                        color: widget.isActive == true
                            ? currentTheme.textTheme.bodyMedium!.color!
                            : currentTheme.textTheme.bodyMedium!.color!
                                .withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.isActive == true
                              ? currentTheme.textTheme.bodyMedium!.color!
                              : currentTheme.textTheme.bodyMedium!.color!
                                  .withOpacity(0),
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
                                color: widget.isActive == true
                                    ? currentTheme.textTheme.bodyMedium!.color!
                                    : currentTheme.textTheme.bodyMedium!.color!
                                        .withOpacity(0.3),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
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
