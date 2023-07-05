// import 'package:antena/shared/app_texts.dart';
// import 'package:antena/theme/palette.dart';
// import 'package:flutter/material.dart';

// //! car condtion
// enum CarCondition {
//   excellent(AppTexts.excellent, Pallete.grnn, AppTexts.excellentDescription),
//   veryGood(
//       AppTexts.veryGood, Pallete.carVeryGood, AppTexts.veryGoodDescription),
//   good(AppTexts.good, Pallete.carGood, AppTexts.goodDescription),
//   fair(AppTexts.fair, Pallete.carFair, AppTexts.fairDescription),
//   poor(AppTexts.poor, Pallete.blackColor, AppTexts.poorDescription);

//   const CarCondition(this.condition, this.color, this.description);
//   final String condition;
//   final String description;
//   final Color color;
// }

// List<CarCondition> carConditions = [
//   CarCondition.excellent,
//   CarCondition.veryGood,
//   CarCondition.good,
//   CarCondition.fair,
//   CarCondition.poor,
// ];

// //! driving routine
// enum DrivingRoutine {
//   cityDriving(AppTexts.cityDriving, Pallete.cityDrivingRed,
//       AppTexts.cityDrivingDescription),
//   highway(AppTexts.highway, Pallete.highwayBlue, AppTexts.highwayDescription),
//   commuting(
//       AppTexts.commuting, Pallete.commutingGrey, AppTexts.commutingDescription),
//   longDistanceTravel(AppTexts.longDistanceTravel,
//       Pallete.longDistanceTravelGreen, AppTexts.longDistanceTravelDescription),
//   dailyShortTrips(AppTexts.dailyShortTrips, Pallete.dailyShortTripsYellow,
//       AppTexts.dailyShortTripsDescription),
//   businessProfessionalUse(
//       AppTexts.businessProfessionalUse,
//       Pallete.businessProfessionalGrey,
//       AppTexts.businessProfessionalUseDescreiption),
//   weekendLeisure(AppTexts.weekendLeisure, Pallete.weekendLeisurePink,
//       AppTexts.weekendLeisureDescription),
//   st(AppTexts.weekendLeisure, Pallete.weekendLeisurePink,
//       AppTexts.weekendLeisureDescription);

//   const DrivingRoutine(this.routine, this.color, this.description);
//   final String routine;
//   final String description;
//   final Color color;
// }

// List<DrivingRoutine> drivingRoutines = [
//   DrivingRoutine.cityDriving,
//   DrivingRoutine.highway,
//   DrivingRoutine.commuting,
//   DrivingRoutine.longDistanceTravel,
//   DrivingRoutine.dailyShortTrips,
//   DrivingRoutine.businessProfessionalUse,
//   DrivingRoutine.weekendLeisure,
// ];

// //! set delivery enums
// enum DeliveryType {
//   homeDelivery('homeDelivery'),
//   pickup('pickup');

//   const DeliveryType(this.deliveryType);
//   final String deliveryType;
// }




// //!/!
// // Using an extension
// // Enhanced enums

// // extension ConvertMessage on String {
// //   MessageEnum toEnum() {
// //     switch (this) {
// //       case 'audio':
// //         return MessageEnum.audio;
// //       case 'image':
// //         return MessageEnum.image;
// //       case 'text':
// //         return MessageEnum.text;
// //       case 'gif':
// //         return MessageEnum.gif;
// //       case 'video':
// //         return MessageEnum.video;
// //       default:
// //         return MessageEnum.text;
// //     }
// //   }
// // }

// // enum MessageEnum {
// //   text('text'),
// //   image('image'),
// //   audio('audio'),
// //   video('video'),
// //   gif('gif');

// //   const MessageEnum(this.type);
// //   final String type;
// // }
