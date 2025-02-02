import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/style.dart';
import '../../../../widget/item_card_list.dart';
import '../controllers/home_controller.dart';

Widget popularItemSection() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 13.h),
          child: Row(
            children: [
              SizedBox(
                height: 24.h,
                child: Text(
                  "MOST_POPULAR_ITEMS".tr,
                  style: fontBold,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: homeController.popularItemDataList.length > 4
                ? 4
                : homeController.popularItemDataList.length,
            itemBuilder: (BuildContext context, index) {
              return itemCardList(
                  homeController.popularItemDataList, index, context);
            }),
      ],
    ),
  );
}
