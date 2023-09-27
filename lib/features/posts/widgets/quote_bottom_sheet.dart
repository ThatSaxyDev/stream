// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/features/posts/widgets/quoting_post_card.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/loader.dart';
import 'package:stream/utils/nav.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stream/utils/snack_bar.dart';
import 'package:stream/utils/widgets/click_button.dart';

class QuotePostBottomSheet extends ConsumerStatefulWidget {
  final PostModel post;
  const QuotePostBottomSheet({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuotePostBottomSheetState();
}

class _QuotePostBottomSheetState extends ConsumerState<QuotePostBottomSheet> {
  final TextEditingController _textController = TextEditingController();
  final ValueNotifier<bool> isButtonActive = ValueNotifier(false);
  
  File? image;

  //! to add an image
  void takePhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
        isButtonActive.value = true;
      });
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      'Failed to pick images: $e'.log();
      showSnackBar(
        context: context,
        text: 'An error occurred',
      );
    }
  }

  //! to quote post
  void quotePost() {
    if (_textController.text.isEmpty &&
        isButtonActive.value == true &&
        image != null) {
      ref.read(postControllerProvider.notifier).quoteAPost2(
            quotedPost: widget.post,
            context: context,
            textContent: '',
            image: image,
          );
    }
    if (_textController.text.isNotEmpty && isButtonActive.value == true) {
      ref.read(postControllerProvider.notifier).quoteAPost2(
            quotedPost: widget.post,
            context: context,
            textContent: _textController.text.trim(),
            image: image,
          );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = ref.watch(userProvider)!;
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    bool isLoading = ref.watch(postControllerProvider);

    UserModel? userr;

    ref
        .watch(getUserProvider(widget.post.userUid!))
        .whenData((value) => userr = value);
    if (userr == null) {
      return const SizedBox.shrink();
    }

    return Container(
      height: height(context) * 0.9,
      width: width(context),
      decoration: BoxDecoration(
        color: currentTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: 10.padH,
        child: Column(
          children: [
            15.sbH,
            //! header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60.w,
                  child: 'Cancel'.txt(),
                ).tap(
                  onTap: () => goBack(context),
                ),
                'Quote'
                    .txt(
                      size: 16.sp,
                      fontWeight: FontWeight.w600,
                    )
                    .tap(
                      onTap: () => goBack(context),
                    ),
                isLoading == true
                    ? SizedBox(
                        height: 35.h,
                        child: const Loader(),
                      )
                    : ValueListenableBuilder(
                        valueListenable: isButtonActive,
                        builder: (context, value, child) {
                          return ClickButton(
                            height: 35.h,
                            width: 60.w,
                            isText: true,
                            text: 'Post',
                            isActive: isButtonActive.value,
                            onTap: () => quotePost(),
                          );
                        }),
              ],
            ),
            10.sbH,
            SizedBox(
              height: height(context) * 0.7,
              width: width(context),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Column(
                  children: [
                    //! image, text field
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 17.w,
                          backgroundImage: NetworkImage(user.profilePic!),
                        ),
                        10.sbW,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            user.isVerified! != true
                                ? '@${user.username!}'.toLowerCase().txt(
                                      size: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    )
                                : Row(
                                    children: [
                                      '@${user.username!}'.toLowerCase().txt(
                                            size: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      7.sbW,
                                      Icon(
                                        Icons.whatshot_sharp,
                                        size: 17.sp,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              width: 250.w,
                              child: TextField(
                                onChanged: (value) {
                                  String typed = value;
                                  if (typed.isNotEmpty) {
                                    isButtonActive.value = true;
                                  } else {
                                    isButtonActive.value = false;
                                  }
                                },
                                autofocus: true,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                                cursorColor:
                                    currentTheme.textTheme.bodyMedium!.color!,
                                controller: _textController,
                                maxLength: 280,
                                decoration: InputDecoration(
                                  hintText:
                                      'What do you think?'.toCapitalized(),
                                  hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            image == null
                                ? Padding(
                                    padding: EdgeInsets.only(right: 8.w),
                                    child:
                                        const Icon(PhosphorIcons.paperclipBold),
                                  ).tap(
                                    onTap: () => takePhoto(ImageSource.gallery),
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 220.h,
                                        width: 200.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          image: DecorationImage(
                                            image: FileImage(
                                              image!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ).tap(
                                        onTap: () =>
                                            takePhoto(ImageSource.gallery),
                                      ),

                                      //! remove image
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            image = null;
                                            isButtonActive.value = false;
                                          });
                                        },
                                        icon: const Icon(PhosphorIcons.x),
                                      ),
                                    ],
                                  ),
                            20.sbH,

                            //! post
                            QuotingPostCard(
                              post: widget.post,
                            ),
                          ],
                        )
                      ],
                    ),
                    400.sbH,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
