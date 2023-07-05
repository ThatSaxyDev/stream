// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:stark/theme/palette.dart';
// import 'package:stark/utils/string_extensions.dart';
// import 'package:stark/utils/widget_extensions.dart';

// import '../features/auth/controllers/auth_controller.dart';

// class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
//   final String? title;
//   const MyAppBar({
//     super.key,
//     this.title,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider)!;
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       foregroundColor: Pallete.blackish,
//       elevation: 0,
//       leading: InkWell(
//         onTap: () {
//           SimpleHiddenDrawerController.of(context).toggle();
//         },
//         child: SvgPicture.asset(
//           'menu'.svg,
//           height: 14.h,
//           fit: BoxFit.scaleDown,
//         ),
//       ),
//       title: Text(
//         title ?? '',
//         style: TextStyle(
//           color: Pallete.blackish,
//           fontSize: 22.sp,
//           fontWeight: FontWeight.bold
//         ),
//       ),
//       actions: [
//         Icon(
//           PhosphorIcons.bell,
//           size: 28.sp,
//         ),
//         11.sbW,
//         CircleAvatar(
//           radius: 16.w,
//           backgroundImage: NetworkImage(user.profilePic),
//         ),
//         20.sbW,
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(50);
// }
