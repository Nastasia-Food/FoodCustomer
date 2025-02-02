import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';

class EmptyCartView extends GetView {
  const EmptyCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.emptyCart,
              height: 180.h,
              width: 180.w,
            ),
            SizedBox(
              height: 32.h,
            ),
            Text(
              "YOUR_CART_IS_EMPTY".tr,
              style: fontMedium,
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'LOOKS_LIKE_YOU_HAVENT_ADDED_ANYTHING'.tr,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13.sp,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 24.h,
            ),
          ],
        ),
      ),
    );
  }
}
