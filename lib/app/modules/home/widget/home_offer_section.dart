// ignore_for_file: sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../offer/controllers/offer_controller.dart';

Widget homeOfferSection() {
  return GetBuilder<OfferController>(
    builder: (offerController) => Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: Get.find<OfferController>().offerDataList.length,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {
                  offerController.getOfferItemList(
                      offerController.offerDataList[index].slug.toString());
                },
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
                      child: Hero(
                        tag: "home-offer-banner-$index",
                        child: CachedNetworkImage(
                          imageUrl: offerController.offerDataList[index].image
                              .toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                // colorFilter: ColorFilter.mode(
                                //     Colors.red,
                                //     BlendMode.colorBurn),
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                            child: Container(
                                height: 60.h, width: 60.w, color: Colors.grey),
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })),
  );
}
