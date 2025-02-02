import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../util/constant.dart';
import '../util/style.dart';

class NoItemsAvailable extends StatelessWidget {
  const NoItemsAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.searchNotFound,
                      height: 120.h,
                      width: 120.w,
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      "NO_ITEM_AVAILABLE".tr,
                      style: fontMedium,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
