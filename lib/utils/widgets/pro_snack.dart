// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_animate/num_duration_extensions.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:jimpact/theme/palette.dart';
// import 'package:jimpact/utils/app_constants.dart';
// import 'package:jimpact/utils/app_extensions.dart';
// import 'package:jimpact/utils/widgets/button.dart';

// final toggleProSnackControllerProvider =
//     StateNotifierProvider<ToggleProSnackController, ProSnack?>((ref) {
//   return ToggleProSnackController();
// });

// //! the state notitfier class for toggling the overlay
// class ToggleProSnackController extends StateNotifier<ProSnack?> {
//   ToggleProSnackController() : super(null);

//   //! show
//   void showProSnacky({required ProSnack proSnack}) {
//     state = proSnack;
//     Timer(2000.ms, () {
//       state = null;
//     });
//   }

//   //! remove
//   void removeProSnack() {
//     state = null;
//   }
// }

// //! () => toggleOverlay
// void showProSnack({
//   required BuildContext context,
//   required WidgetRef ref,
//   required ProSnack proSnack,
// }) {
//   ref
//       .read(toggleProSnackControllerProvider.notifier)
//       .showProSnacky(proSnack: proSnack);
// }

// void removeProSnack({
//   required BuildContext context,
//   required WidgetRef ref,
// }) {
//   ref.read(toggleProSnackControllerProvider.notifier).removeProSnack();
// }

// class ProSnack {
//   final String? title;
//   final String? description;

//   const ProSnack({
//     required this.title,
//     required this.description,
//   });
// }

// class PopUpOverLayWidget extends ConsumerWidget {
//   final ProSnack? overlay;
//   final void Function()? onButtonTap;
//   const PopUpOverLayWidget({
//     super.key,
//     required this.overlay,
//     this.onButtonTap,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return const Material(
//       elevation: 0,
//       color: Colors.transparent,
//       child: SizedBox(),
//     );
//   }
// }
