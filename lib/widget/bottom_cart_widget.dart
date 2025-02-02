// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app/modules/cart/controllers/cart_controller.dart';
import '../app/modules/cart/views/cart_view.dart';
import '../app/modules/splash/controllers/splash_controller.dart';
import '../util/constant.dart';
import '../util/style.dart';

class BottomCartWidget extends StatelessWidget {
  const BottomCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        builder: (cartController) => cartController.cart.isNotEmpty
            ? Positioned(
                bottom: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                          () => CartView(
                                fromNav: false,
                              ),
                          transition: Transition.cupertino);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: Size(Get.width - 32, 48.h),
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "VIEW_CART".tr +
                              " "
                                  "(" +
                              cartController.cart.length.toString() +
                              " " +
                              "ITEMS_ADDED".tr +
                              ")" +
                              " " +
                              Get.find<SplashController>()
                                  .configData
                                  .siteDefaultCurrencySymbol! +
                              cartController.totalCartValue.toStringAsFixed(2),
                          style: fontRegularBold,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox());
  }
}
