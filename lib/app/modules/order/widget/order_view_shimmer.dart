import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';

class OrderViewShimmer extends GetView {
  const OrderViewShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        activeOrderSection(),
        SizedBox(
          height: 24.h,
        ),
        previousOrders(),
      ],
    );
  }
}

Widget previousOrders() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            height: 30.h,
            width: 150.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r), color: Colors.white),
          ),
        ),
      ),
      SizedBox(
        height: 12.h,
      ),
      ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (BuildContext context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[300]!,
              child: Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 12.h),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    height: 96.h,
                    width: 328.w,
                    padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.white,
                        border: Border.all(color: AppColor.itembg)),
                  ),
                ]),
              ),
            );
          }),
    ],
  );
}

Widget activeOrderSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            height: 30.h,
            width: 150.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r), color: Colors.white),
          ),
        ),
      ),
      SizedBox(
        height: 14.h,
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[300]!,
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 96.h,
              width: 328.w,
              padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white,
                  border: Border.all(color: AppColor.itembg)),
            ),
          ]),
        ),
      ),
    ],
  );
}
