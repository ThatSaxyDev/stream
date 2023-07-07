// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/posts/controllers/post_controller.dart';
import 'package:stream/features/profile/controllers/profile_controller.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/utils/app_constants.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/loader.dart';
import 'package:stream/utils/nav.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stream/utils/snack_bar.dart';
import 'package:stream/utils/widgets/click_button.dart';

class EditProfileBottomSheet extends ConsumerStatefulWidget {
  const EditProfileBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState
    extends ConsumerState<EditProfileBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final ValueNotifier<bool> isButtonActive = ValueNotifier(false);
  File? image;

  //! to add an image
  void takePhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(
        () => this.image = imageTemp,
      );

      ref
          .read(userProfileControllerProvider.notifier)
          .editUserProfileImage(context: context, profileFile: imageTemp);
    } on PlatformException catch (e) {
      'Failed to pick images: $e'.log();
      showSnackBar(
        context: context,
        text: 'An error occurred',
      );
    }
  }

  //! to create post
  // void createPost() {
  //   if (_textController.text.isEmpty &&
  //       isButtonActive.value == true &&
  //       image != null) {
  //     ref.read(postControllerProvider.notifier).createPost(
  //           context: context,
  //           textContent: '',
  //           image: image,
  //         );
  //   }
  //   if (_textController.text.isNotEmpty && isButtonActive.value == true) {
  //     ref.read(postControllerProvider.notifier).createPost(
  //           context: context,
  //           textContent: _textController.text.trim(),
  //           image: image,
  //         );
  //   }
  // }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _linkController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = ref.watch(userProvider)!;
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    bool isLoading = ref.watch(postControllerProvider);
    bool isProfileLoading = ref.watch(userProfileControllerProvider);
    return Container(
      height: height(context) * 0.9,
      width: width(context),
      decoration: BoxDecoration(
        color: currentTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: 24.padH,
        child: Column(
          children: [
            15.sbH,
            //! header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   width: 60.w,
                //   child: 'Cancel'.txt(),
                // ).tap(
                //   onTap: () => goBack(context),
                // ),
                60.sbW,
                'Edit Profile'
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
                            text: 'Done',
                            isActive: true,
                            onTap: () {
                              goBack(context);
                            },
                          );
                        }),
              ],
            ),
            SizedBox(
              height: height(context) * 0.7,
              width: width(context),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Column(
                  children: [
                    20.sbH,
                    switch (isProfileLoading) {
                      true => const Loadinggg(),
                      false => SizedBox.square(
                          dimension: 70.w,
                          child: Stack(
                            children: [
                              image != null
                                  ? CircleAvatar(
                                      backgroundImage: FileImage(image!),
                                      radius: 32.r,
                                    )
                                  : CircleAvatar(
                                      radius: 35.w,
                                      backgroundImage:
                                          NetworkImage(user.profilePic!),
                                    ),
                              CircleAvatar(
                                radius: 35.w,
                                backgroundColor: Colors.black.withOpacity(0.4),
                              ),
                              const Icon(
                                PhosphorIcons.penBold,
                                color: Pallete.whiteColor,
                              ).alignCenter(),
                            ],
                          ),
                        ).tap(
                          onTap: () => takePhoto(ImageSource.gallery),
                        ),
                    },
                    20.sbH,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.sbW,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! name
                            SizedBox(
                              width: 250.w,
                              child: TextField(
                                // onChanged: (value) {
                                //   String typed = value;
                                //   if (typed.isNotEmpty) {
                                //     isButtonActive.value = true;
                                //   } else {
                                //     isButtonActive.value = false;
                                //   }
                                // },
                                autofocus: true,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                                cursorColor:
                                    currentTheme.textTheme.bodyMedium!.color!,
                                controller: _nameController,
                                onSubmitted: (value) {
                                  ref
                                      .read(userProfileControllerProvider
                                          .notifier)
                                      .editUserProfile(
                                        context: context,
                                        user: user.copyWith(
                                          name: value.trim().toTitleCase(),
                                        ),
                                      );
                                  _nameController.clear();
                                },
                                decoration: InputDecoration(
                                  hintText: 'name: ${user.name}',
                                  hintStyle: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            //! user name
                            SizedBox(
                              width: 250.w,
                              child: TextField(
                                // onChanged: (value) {
                                //   String typed = value;
                                //   if (typed.isNotEmpty) {
                                //     isButtonActive.value = true;
                                //   } else {
                                //     isButtonActive.value = false;
                                //   }
                                // },
                                // autofocus: true,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                                cursorColor:
                                    currentTheme.textTheme.bodyMedium!.color!,
                                controller: _usernameController,
                                onSubmitted: (value) {
                                  ref
                                      .read(userProfileControllerProvider
                                          .notifier)
                                      .editUserProfile(
                                        context: context,
                                        user: user.copyWith(
                                          username: value.trim().toLowerCase(),
                                        ),
                                      );
                                  _usernameController.clear();
                                },
                                decoration: InputDecoration(
                                  hintText: 'username: @${user.username!}'
                                      .toLowerCase(),
                                  hintStyle: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            //! link
                            SizedBox(
                              width: 250.w,
                              child: TextField(
                                // onChanged: (value) {
                                //   String typed = value;
                                //   if (typed.isNotEmpty) {
                                //     isButtonActive.value = true;
                                //   } else {
                                //     isButtonActive.value = false;
                                //   }
                                // },
                                autofocus: true,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                                cursorColor:
                                    currentTheme.textTheme.bodyMedium!.color!,
                                controller: _linkController,
                                onSubmitted: (value) {
                                  ref
                                      .read(userProfileControllerProvider
                                          .notifier)
                                      .editUserProfile(
                                        context: context,
                                        user: user.copyWith(
                                          link: value.trim().toLowerCase(),
                                        ),
                                      );
                                  _linkController.clear();
                                },
                                decoration: InputDecoration(
                                  hintText: user.link!.isEmpty
                                      ? 'link: https://'
                                      : 'link: ${user.link!}'.toLowerCase(),
                                  hintStyle: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            //! bio
                            Row(
                              children: [
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
                                    maxLines: 3,
                                    maxLength: 100,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                    ),
                                    cursorColor: currentTheme
                                        .textTheme.bodyMedium!.color!,
                                    controller: _bioController,
                                    decoration: InputDecoration(
                                      hintText:
                                          'bio: ${user.banner!}'.toLowerCase(),
                                      hintStyle: TextStyle(
                                        fontSize: 16.sp,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: isButtonActive,
                                    builder: (context, value, child) {
                                      if (isButtonActive.value == true) {
                                        return IconButton(
                                          onPressed: () {
                                            ref
                                                .read(
                                                    userProfileControllerProvider
                                                        .notifier)
                                                .editUserProfile(
                                                  context: context,
                                                  user: user.copyWith(
                                                    banner: _bioController.text
                                                        .trim()
                                                        .toLowerCase(),
                                                  ),
                                                );
                                            isButtonActive.value = false;
                                            _bioController.clear();
                                          },
                                          icon: const Icon(
                                              PhosphorIcons.checkBold),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }),
                              ],
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
