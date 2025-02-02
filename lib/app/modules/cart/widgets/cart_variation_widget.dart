import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../controllers/cart_controller.dart';

Widget cartVariationSection(int cartIndex) {
  final cartController = Get.find<CartController>();
  return Padding(
    padding: EdgeInsets.only(
      top: 8.h,
    ),
    child: Column(
      children: [
        cartController.cart[cartIndex].itemExtras != null &&
                cartController.cart[cartIndex].itemExtras!.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(bottom: 4.h, right: 8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EXTRAS".tr,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 220.w,
                      height: 15.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount:
                            cartController.cart[cartIndex].itemExtras!.length,
                        itemBuilder: (BuildContext context, index) {
                          return Text(
                            index ==
                                    cartController.cart[cartIndex].itemExtras!
                                            .length -
                                        1
                                ? "${cartController.cart[cartIndex].itemExtras![index].name}."
                                : "${cartController.cart[cartIndex].itemExtras![index].name},",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.gray),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}
