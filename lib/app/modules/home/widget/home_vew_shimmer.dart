import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../util/constant.dart';

Widget menuSectionShimmer() {
  return Column(
    children: [
      SizedBox(
        height: 20.h,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: 30.h,
              width: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: 30.h,
              width: 60.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white),
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 12.h,
      ),
      SizedBox(
        width: double.infinity,
        height: 90.h,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[300]!,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Container(
                    height: 90.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
      ),
    ],
  );
}

Widget featureditemSectionShimmer() {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 24.h, bottom: 13.h),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[300]!,
              child: Container(
                height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 500.h,
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
  );
}

Widget homeOfferSectionShimmer() {
  return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[300]!,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  height: 84.h,
                  width: 328.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset(
                      height: 84.h,
                      width: 328.w,
                      Images.offer3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }));
}

Widget popularItemSectionShimmer() {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 24.h, bottom: 13.h),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[300]!,
              child: Container(
                height: 30.h,
                width: 200.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
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
  );
}
