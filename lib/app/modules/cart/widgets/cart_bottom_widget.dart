import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../auth/views/login_view.dart';
import '../../checkout/views/checkout_view.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/cart_controller.dart';

Widget cartBottomSection() {
  final box = GetStorage();
  final cartController = Get.find<CartController>();
  return Padding(
    padding: EdgeInsets.only(
      left: 16.w,
      top: 10.h,
      right: 16.w,
    ),
    child: Column(
      children: [
        Container(
          height: 48.h,
          width: 328.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
            border: Border.all(color: AppColor.itembg),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SUBTOTAL".tr,
                  style: fontRegularBold,
                ),
                Get.find<SplashController>().configData.siteCurrencyPosition ==
                        5
                    ? Row(
                        children: [
                          Text(
                            Get.find<SplashController>()
                                .configData
                                .siteDefaultCurrencySymbol!,
                            style: fontRegularBoldGreen,
                          ),
                          Text(
                            // ignore: unnecessary_string_interpolations
                            "${cartController.totalCartValue.toStringAsFixed(int.parse(Get.find<SplashController>().configData.siteDigitAfterDecimalPoint.toString()))}",
                            style: fontRegularBoldGreen,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            // ignore: unnecessary_string_interpolations
                            "${cartController.totalCartValue.toStringAsFixed(int.parse(Get.find<SplashController>().configData.siteDigitAfterDecimalPoint.toString()))}",
                            style: fontRegularBoldGreen,
                          ),
                          Text(
                            Get.find<SplashController>()
                                .configData
                                .siteDefaultCurrencySymbol!,
                            style: fontRegularBoldGreen,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                if (box.read('isLogedIn')) {
                  Get.to(
                    () => CheckoutView(),
                  );
                } else {
                  Get.to(LoginView());
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColor.primaryColor,
                minimumSize: Size(328.w, 52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
              ),
              child: Text(
                "PROCCED_TO_CHECKOUT".tr,
                style: fontMedium,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
