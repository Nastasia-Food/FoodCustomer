import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../util/constant.dart';

Widget menuItemSectionGridShimmer() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 16.h),
    child: Column(
      children: [
        SizedBox(
          height: Get.height / 1.7,
          child: GridView.builder(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 201,
                  childAspectRatio: 2 / 2.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 17),
              itemCount: 4,
              itemBuilder: (BuildContext ctx, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: 207.h,
                    width: 156.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.white,
                        border: Border.all(color: AppColor.itembg)),
                  ),
                );
              }),
        ),
      ],
    ),
  );
}

Widget menuItemSectionListShimmer() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 16.h),
    child: Column(
      children: [
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[300]!,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Container(
                    height: 100.h,
                    width: 328.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.white,
                        border: Border.all(color: AppColor.itembg)),
                  ),
                ),
              );
            }),
      ],
    ),
  );
}
