import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../home/controllers/home_controller.dart';
import '../../item/views/item_view.dart';

Widget cartFrequentlySection() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Padding(
      padding: EdgeInsets.only(
        top: 24.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Text(
              "FREQUENTLY_BOUGHT_TOGETHER".tr,
              style: fontMediumPro,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            width: double.infinity,
            height: 60.h,
            child: SingleChildScrollView(
              primary: false,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController.itemDataList.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => SingleChildScrollView(
                              child: ItemView(
                                  itemDetails:
                                      homeController.itemDataList[index]),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 9.w),
                          child: Container(
                            height: 60.h,
                            width: 240.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white,
                              border: Border.all(color: AppColor.itembg),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 60.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 60.w,
                                        height: 60.h,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.r)),
                                          child: CachedNetworkImage(
                                            imageUrl: homeController
                                                .itemDataList[index].cover!,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              // ignore: sort_child_properties_last
                                              child: Container(
                                                  height: 130,
                                                  width: 200,
                                                  color: Colors.grey),
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[400]!,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 8.w,
                                  ),
                                  child: SizedBox(
                                    height: 60.h,
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: SizedBox(
                                                width: 140.w,
                                                child: Text(
                                                  homeController
                                                      .itemDataList[index]
                                                      .name!,
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13.sp,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14.w,
                                              height: 14.h,
                                              child: SvgPicture.asset(
                                                Images.iconDetails,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 6.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                homeController
                                                    .itemDataList[index]
                                                    .currencyPrice!,
                                                style: fontRegularBold,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4.r),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColor.itembg,
                                                      offset: const Offset(
                                                        0.0,
                                                        4.0,
                                                      ),
                                                      blurRadius: 5.r,
                                                      spreadRadius: 1.r,
                                                    ),
                                                    BoxShadow(
                                                      color: AppColor.itembg,
                                                      offset: const Offset(
                                                        1.0,
                                                        0.0,
                                                      ),
                                                      blurRadius: 1.r,
                                                      spreadRadius: 0.1.r,
                                                    ), //BoxShadow
                                                    //BoxShadow
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 12.w,
                                                      height: 12.h,
                                                      child: SvgPicture.asset(
                                                        Images.iconCart,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      "ADD".tr,
                                                      style:
                                                          fontRegularBoldwithColor,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
