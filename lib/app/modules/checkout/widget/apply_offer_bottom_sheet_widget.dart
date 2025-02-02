// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/custom_toast.dart';
import '../../../../widget/loader.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/coupon_controller.dart';

class ApplyOfferView extends StatefulWidget {
  const ApplyOfferView({Key? key}) : super(key: key);

  @override
  State<ApplyOfferView> createState() => _ApplyOfferViewState();
}

class _ApplyOfferViewState extends State<ApplyOfferView> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.gray.withOpacity(0.5),
              offset: const Offset(
                0.0,
                6.0,
              ),
              blurRadius: 30.r,
              spreadRadius: 10.r,
            ),
            //BoxShadow
            //BoxShadow
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ENTER_COUPON_CODE".tr,
                        style: fontRegularBold,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: SvgPicture.asset(
                            Images.IconClose,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 60.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60.h,
                            child: SizedBox(
                              child: TextField(
                                readOnly: false,
                                expands: false,
                                controller: cartController.couponTextController,
                                decoration: InputDecoration(
                                  fillColor: AppColor.searchBarbg,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: box.read('languageCode') ==
                                            'ar'
                                        ? BorderRadius.only(
                                            topRight: Radius.circular(12.r),
                                            bottomRight: Radius.circular(12.r),
                                          )
                                        : BorderRadius.only(
                                            topLeft: Radius.circular(12.r),
                                            bottomLeft: Radius.circular(12.r),
                                          ),
                                    borderSide: BorderSide(
                                        color: AppColor.searchBarbg,
                                        width: 2.0.w),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: box.read('languageCode') ==
                                            'ar'
                                        ? BorderRadius.only(
                                            topRight: Radius.circular(12.r),
                                            bottomRight: Radius.circular(12.r),
                                          )
                                        : BorderRadius.only(
                                            topLeft: Radius.circular(12.r),
                                            bottomLeft: Radius.circular(12.r),
                                          ),
                                    borderSide: BorderSide(
                                        width: 2.w,
                                        color: AppColor.dividerColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                          child: InkWell(
                            onTap: () async {
                              if (cartController
                                  .couponTextController.text.isNotEmpty) {
                                cartController.checkCoupon();
                              } else {
                                customTast("PLEASE_SELECT_AN_COUPON".tr,
                                    AppColor.error);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                  borderRadius: box.read('languageCode') == 'ar'
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(12.r),
                                          bottomLeft: Radius.circular(12.r),
                                        )
                                      : BorderRadius.only(
                                          topRight: Radius.circular(12.r),
                                          bottomRight: Radius.circular(12.r),
                                        ),
                                  color: Colors.green),
                              child: Center(
                                child: Text(
                                  "APPLY".tr,
                                  style: fontMediumProWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<CouponController>(
                    builder: (couponController) => Padding(
                      padding: EdgeInsets.only(
                        top: 24.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "OFFER_FOR_YOU".tr,
                            style: fontMedium,
                          ),
                          Text(
                            "COUPON_BUILT_JUST_FOR_YOU".tr,
                            style: fontRegular,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          couponController.couponDataList.isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      couponController.couponDataList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColor.itembg,
                                              offset: const Offset(
                                                0.0,
                                                4.0,
                                              ),
                                              blurRadius: 5.0.r,
                                              spreadRadius: 0.5.r,
                                            ),
                                            const BoxShadow(
                                              color: AppColor.itembg,
                                              offset: Offset(
                                                0.0,
                                                0.0,
                                              ),
                                              blurRadius: 1.0,
                                              spreadRadius: 0.1,
                                            ), //BoxShadow
                                            //BoxShadow
                                          ],
                                        ),
                                        // elevation: 0.8,
                                        // shape: RoundedRectangleBorder(
                                        //     borderRadius: BorderRadius.circular(8.r)),
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 8.h),
                                          child: SizedBox(
                                            width: 328.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8.w,
                                                                  right: 8.w,
                                                                  top: 8.h),
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8.h,
                                                                    vertical:
                                                                        4.w),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(4
                                                                            .r),
                                                                color: AppColor
                                                                    .yellow),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Center(
                                                                  child: Text(
                                                                    couponController
                                                                        .couponDataList[
                                                                            index]
                                                                        .code
                                                                        .toString(),
                                                                    style:
                                                                        fontRegularBold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            cartController
                                                                    .couponTextController
                                                                    .text =
                                                                couponController
                                                                    .couponDataList[
                                                                        index]
                                                                    .code!;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.r),
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              8.r),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8.r),
                                                                    ),
                                                                    color: AppColor
                                                                        .primaryColor),
                                                            child: Center(
                                                              child: Text(
                                                                "APPLY".tr,
                                                                style:
                                                                    fontRegularBoldwithWhiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.w,
                                                          right: 8.w),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "GET".tr + " ",
                                                            style: fontRegular,
                                                          ),
                                                          Text(
                                                            double.parse(couponController
                                                                    .couponDataList[
                                                                        index]
                                                                    .discount!)
                                                                .toString(),
                                                            style: fontRegular,
                                                          ),
                                                          Text(
                                                            " " +
                                                                "OFF_ON_ORDER_ABOVE"
                                                                    .tr +
                                                                " ",
                                                            style: fontRegular,
                                                          ),
                                                          Text(
                                                            double.parse(couponController
                                                                    .couponDataList[
                                                                        index]
                                                                    .minimumOrder!)
                                                                .toString(),
                                                            style: fontRegular,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(),
                                                ExpandableNotifier(
                                                  // <-- Provides ExpandableController to its children
                                                  child: Column(
                                                    children: [
                                                      Expandable(
                                                        // <-- Driven by ExpandableController from ExpandableNotifier
                                                        collapsed:
                                                            ExpandableButton(
                                                          // <-- Expands when tapped on the cover photo
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8.w,
                                                                    right: 8.w),
                                                            child: Text(
                                                              "TERMS_AND_CONDITION"
                                                                  .tr,
                                                              style:
                                                                  fontRegularWithColor,
                                                            ),
                                                          ),
                                                        ),
                                                        expanded:
                                                            Column(children: [
                                                          ExpandableButton(
                                                            // <-- Collapses when tapped on
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 8.w,
                                                                      right:
                                                                          8.w),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "TERMS_AND_CONDITION"
                                                                        .tr,
                                                                    style:
                                                                        fontRegularWithColor,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 8.h,
                                                                  ),
                                                                  Text(
                                                                    couponController
                                                                        .couponDataList[
                                                                            index]
                                                                        .description
                                                                        .toString(),
                                                                    style:
                                                                        fontRegular,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 6,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Container(
                                    height: 60.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: AppColor.primaryColor
                                            .withOpacity(0.08),
                                        border: Border.all(
                                            color: AppColor.primaryColor)),
                                    child: Center(
                                        child: Text(
                                      "NO_COUPON_AVAILABLE".tr,
                                      style: fontRegularBold,
                                    )),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            cartController.couponLoading
                ? Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.white60,
                      ),
                      height: 480.h,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: LoaderCircle(),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
