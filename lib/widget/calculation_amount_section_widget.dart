import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../util/constant.dart';

Widget calculationAmountSection(controller) {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
      side: const BorderSide(
        color: AppColor.dividerColor,
      ),
    ),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.r),
          child: Row(
            children: [
              Text(
                'SUBTOTAL'.tr,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                " 10.00",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.r),
          child: Row(
            children: [
              Text(
                'DISCOUNT'.tr,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                " 2.00",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.r),
          child: Row(
            children: [
              Text(
                'DELIVERY_CHARGE'.tr,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                "10",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const Text(
          '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
          style: TextStyle(color: Colors.grey),
        ),
        Padding(
          padding: EdgeInsets.all(8.r),
          child: Row(
            children: [
              Text(
                'TOTAL'.tr,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                "40.00",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
