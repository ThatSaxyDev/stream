// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/theme/palette.dart';

import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/widgets/image_loader.dart';

class ImageOverLay extends ConsumerWidget {
  final String imageUrl;
  const ImageOverLay({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      elevation: 0,
      color: Colors.black.withOpacity(0.5),
      child: SizedBox(
        height: height(context),
        width: width(context),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Stack(
            children: [
              InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(double.infinity),
                minScale: 0.1,
                maxScale: 5.0,
                child: ImageLoaderForOverlay(
                  height: height(context) * 0.75,
                  width: width(context),
                  imageUrl: imageUrl,
                ),
              ).alignCenter(),
              Column(
                children: [
                  50.sbH,
                  IconButton(
                    onPressed: () {
                      ref
                          .read(imageOverlayControllerProvider.notifier)
                          .removeImageFromOverlay();
                    },
                    icon: Icon(
                      PhosphorIconsRegular.x,
                      color: Pallete.whiteColor,
                      size: 35.sp,
                    ),
                  ).fadeIn(delay: 200.ms).alignCenterLeft(),
                ],
              ),
            ],
          ),
        ),
      ).tap(
        onTap: () {
          ref
              .read(imageOverlayControllerProvider.notifier)
              .removeImageFromOverlay();
        },
      ),
    );
  }
}
