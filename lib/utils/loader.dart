// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';

// class Loader extends StatelessWidget {
//   const Loader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: LoadingAnimationWidget.halfTriangleDot(
//         color: Pallete.whiteColor,
//         size: 60.w,
//       ),
//     );
//   }
// }

class Loader extends ConsumerWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final currenTheme = ref.watch(themeNotifierProvider);
    return Center(
      child: SizedBox(
        height: 60.h,
        width: 60.h,
        // child: CircularProgressIndicator(
        //   color: Pallete.blueColor,
        // ),
        child: LoadingAnimationWidget.inkDrop(
          color: Pallete.textBlack,
          size: 60.h,
        ),
      ),
    );
  }
}

class Loadinggg extends StatefulWidget {
  final double? height;
  const Loadinggg({
    Key? key,
    this.height,
  }) : super(key: key);

  @override
  State<Loadinggg> createState() => _LoadingggState();
}

class _LoadingggState extends State<Loadinggg>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: RotationTransition(
            turns: _animationController,
            child: Icon(
              PhosphorIcons.placeholder,
              size: widget.height ?? 30.h,
            ),
          ),
        );
      },
    );
  }
}

class Rezult extends StatefulWidget {
  final Widget rezult;
  final double dimension;
  const Rezult({
    Key? key,
    required this.rezult,
    required this.dimension,
  }) : super(key: key);

  @override
  State<Rezult> createState() => _RezultState();
}

class _RezultState extends State<Rezult> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: SizedBox.square(
            dimension: widget.dimension + _animationController.value * 30.0,
            child: widget.rezult,
          ),
        );
      },
    );
  }
}
