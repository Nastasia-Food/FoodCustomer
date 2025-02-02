// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';

Alert permissionAlert(context) {
  return Alert(
    closeIcon: const Text(''),
    style: AlertStyle(
      animationType: AnimationType.grow,
      descStyle: fontMedium,
      descTextAlign: TextAlign.center,
      animationDuration: const Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0.r),
      ),
      alertAlignment: Alignment.center,
    ),
    context: context,
    desc: "Location permission is not enabled!",
    image: SvgPicture.asset(
      Images.locationService,
      height: 120.h,
      width: 120.w,
    ),
    buttons: [
      DialogButton(
        child: Text(
          "CANCEL".tr,
          style: fontMediumPro,
        ),
        color: AppColor.itembg,
        onPressed: () => Navigator.pop(context),
        radius: BorderRadius.circular(24.0.r),
      ),
      DialogButton(
        child: Text(
          "ENABLE".tr,
          style: fontMediumProWhite,
        ),
        color: AppColor.primaryColor,
        onPressed: () async {
          await Geolocator.openAppSettings();
        },
        radius: BorderRadius.circular(24.0.r),
      ),
    ],
  );
}
