// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';

class searchNotFound extends StatelessWidget {
  const searchNotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'SEARCH'.tr,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: SvgPicture.asset(Images.back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 52.h,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                  hintText: "SEARCH".tr,
                  hintStyle: const TextStyle(color: AppColor.gray),
                  prefixIcon: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: SvgPicture.asset(
                        Images.iconSearch,
                        fit: BoxFit.cover,
                        color: AppColor.gray,
                        height: 16.h,
                        width: 16.w,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: AppColor.itembg,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    borderSide: BorderSide(color: AppColor.itembg, width: 1.w),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    borderSide: BorderSide(width: 0.w, color: AppColor.itembg),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.searchNotFound,
                      height: 180.h,
                      width: 180.w,
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      "RESULT_NOT_FOUND".tr,
                      style: fontMedium,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'RESULT_NOT_FOUND_DESCRIPTION'.tr,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.sp,
                          fontFamily: 'Rubkik',
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
