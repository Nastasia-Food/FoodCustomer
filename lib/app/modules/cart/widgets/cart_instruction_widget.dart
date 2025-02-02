// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../controllers/cart_controller.dart';

Widget cartInstructionSection(int cartIndex) {
  final cartController = Get.find<CartController>();
  return Column(
    children: [
      cartController.cart[cartIndex].instruction != null &&
              cartController.cart[cartIndex].instruction!.isNotEmpty
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "INSTRUCTION".tr + ' : ',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: Get.width - 140,
                  child: Text(
                    cartController.cart[cartIndex].instruction.toString(),
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.gray),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                )
              ],
            )
          : const SizedBox.shrink(),
    ],
  );
}
