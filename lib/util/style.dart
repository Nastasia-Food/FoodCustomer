// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constant.dart';

class Dimensions {
  static double fontSizeExtraSmallSamll = 8;
  static double fontSizeExtraSmall = 10;
  static double fontSizeSmall = 12;
  static double fontSizeDefault = 14;
  static double fontSizeReasonHeading = 14;
  static double fontSizeReasonText = 12;
  static double fontSizeLarge = 16;
  static double fontSizeExtraLarge = 18;
  static double fontSizeExtraLarge22 = 22;
  static double fontSizeOverLarge = 26;
}

class ScreenSize {
  BuildContext context;
  ScreenSize(this.context);
  double get mainHeight => MediaQuery.of(context).size.height;
  double get mainWidth => MediaQuery.of(context).size.width;
  double get block => mainWidth / 100;
}

final fontSizeSmall = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeExtraSmall.sp,
);
final fontSizeSmallGray = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  color: AppColor.gray,
  fontSize: Dimensions.fontSizeExtraSmall.sp,
);

final fontSizeReasonText = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeReasonText.sp,
);

final fontSizeReason = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeReasonHeading.sp,
);

final fontSmall = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeExtraSmallSamll.sp,
);
final fontSmallwithColor = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  color: AppColor.primaryColor,
  fontSize: Dimensions.fontSizeSmall.sp,
);
final fontSmallBold = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w500,
  fontSize: 11,
);

final fontRegular = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeSmall.sp,
);
final fontRegularWithColor = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  color: AppColor.primaryColor,
  fontSize: Dimensions.fontSizeSmall.sp,
);
final fontRegularLite = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
);
final fontRegularBold = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w500,
  fontSize: 14.sp,
);
final fontRegularBoldwithWhiteColor = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: Dimensions.fontSizeSmall.sp,
);
final fontRegularBoldGreen = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  color: AppColor.green,
  fontSize: 14.sp,
);
final fontRegularBoldwithColor = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeSmall.sp,
  color: AppColor.primaryColor,
);

final fontMedium = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeLarge.sp,
);
final fontMediumPro = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault.sp,
);

final fontMediumProWhite = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontSize: Dimensions.fontSizeDefault.sp,
);
final fontSemiBold = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w500,
  fontSize: 16.sp,
);

final fontBold = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeExtraLarge.sp,
);
final fontBoldWithColor = TextStyle(
    fontFamily: 'Rubik',
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    color: AppColor.primaryColor);
final fontBoldWithColorBlack = TextStyle(
    fontFamily: 'Rubik',
    fontWeight: FontWeight.w600,
    fontSize: Dimensions.fontSizeExtraLarge.sp,
    color: Colors.black);

final fontBlack = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeOverLarge.sp,
);
final fontSizeExtraLarge22 = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeExtraLarge22.sp,
);

final fontProfile = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.fontColor);

final fontProfileLite = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.fontColor);
