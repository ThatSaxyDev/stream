// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_extensions.dart';

class ImageLoader extends ConsumerWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double? radius;
  const ImageLoader({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 8.r),
      child: CachedNetworkImage(
        height: height ?? 83.h,
        width: width ?? 84.w,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black12.withOpacity(0.1),
                Colors.black12.withOpacity(0.1),
                Colors.black26,
                Colors.black26,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1200.ms),
        errorWidget: (context, url, error) => Container(
          color: Pallete.greey.withOpacity(0.1),
          child: Center(
            child: Icon(
              Icons.error,
              size: 30.sp,
            ),
          ),
        ),
      ),
    ).tap(onTap: () {
      ref
          .read(imageOverlayControllerProvider.notifier)
          .addImageToOverLay(imageUrl: imageUrl);
    });
  }
}

//! circular image loader
class CircularImageLoader extends ConsumerWidget {
  final String imageUrl;
  final double? dimension;
  const CircularImageLoader({
    Key? key,
    required this.imageUrl,
    this.dimension,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(dimension ?? 36.r),
      child: CachedNetworkImage(
        height: dimension ?? 36.h,
        width: dimension ?? 36.w,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black12.withOpacity(0.1),
                Colors.black12.withOpacity(0.1),
                Colors.black26,
                Colors.black26,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1200.ms),
        errorWidget: (context, url, error) => Container(
          color: Pallete.greey.withOpacity(0.1),
          child: Center(
            child: Icon(
              Icons.error,
              size: 30.sp,
            ),
          ),
        ),
      ),
    ).tap(onTap: () {
      ref
          .read(imageOverlayControllerProvider.notifier)
          .addImageToOverLay(imageUrl: imageUrl);
    });
  }
}

//! image overlay
final imageOverlayControllerProvider =
    StateNotifierProvider<ImageOverlayController, String?>((ref) {
  return ImageOverlayController();
});

class ImageOverlayController extends StateNotifier<String?> {
  ImageOverlayController() : super(null);

  //! add image
  void addImageToOverLay({required String imageUrl}) {
    state = imageUrl;
  }

  //! remove image
  void removeImageFromOverlay() {
    state = null;
  }
}

class ImageLoaderForOverlay extends ConsumerWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  const ImageLoaderForOverlay({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: CachedNetworkImage(
        height: height ?? 83.h,
        width: width ?? 84.w,
        fit: BoxFit.contain,
        imageUrl: imageUrl,
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black12.withOpacity(0.1),
                Colors.black12.withOpacity(0.1),
                Colors.black26,
                Colors.black26,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1200.ms),
        errorWidget: (context, url, error) => Container(
          color: Pallete.greey.withOpacity(0.1),
          child: Center(
            child: Icon(
              Icons.error,
              size: 30.sp,
            ),
          ),
        ),
      ),
    );
  }
}
