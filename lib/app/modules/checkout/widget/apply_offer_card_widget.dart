// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../splash/controllers/splash_controller.dart';
import 'apply_offer_bottom_sheet_widget.dart';

class ApplyOfferCard extends StatefulWidget {
  const ApplyOfferCard({
    super.key,
    required this.splashController,
  });

  final SplashController splashController;

  @override
  State<ApplyOfferCard> createState() => _ApplyOfferCardState();
}

class _ApplyOfferCardState extends State<ApplyOfferCard> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) => Padding(
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          top: 16.h,
        ),
        child: Column(
          children: [
            !cartController.couponAplied
                ? InkWell(
                    onTap: () {
                      showBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ApplyOfferView(),
                      );
                    },
                    child: Container(
                      height: 70.h,
                      // width: 304.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColor.itembg),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 26.w,
                                    height: 26.h,
                                    child: SvgPicture.asset(
                                      Images.iconPromo,
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 14.w,
                                ),
                                SizedBox(
                                  width: 210.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "SELECT_OFFER_APPLY_COUPON".tr,
                                        style: fontRegularBold,
                                      ),
                                      Text(
                                        "GET_DISCOUNT_WITH_YOUR_ORDER".tr,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: 'Rubik',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                child: box.read('languageCode') == 'ar'
                                    ? Transform.rotate(
                                        angle: pi,
                                        child: SvgPicture.asset(
                                          Images.iconArrowRight,
                                          fit: BoxFit.cover,
                                        ))
                                    : SvgPicture.asset(
                                        Images.iconArrowRight,
                                        fit: BoxFit.cover,
                                      )),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 50.h,
                    width: 304.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColor.itembg),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.r),
                                    topLeft: Radius.circular(8.r),
                                  ),
                                  color: AppColor.green),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: SvgPicture.asset(
                                          Images.tick,
                                          fit: BoxFit.cover,
                                          color: Colors.white,
                                        )),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "OFFER".tr,
                                          style: fontRegularBoldwithWhiteColor,
                                        ),
                                        Text(
                                          "APPLIED".tr,
                                          style: fontRegularBoldwithWhiteColor,
                                        ),
                                      ],
                                    )
                                  ]),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            SizedBox(
                              width: 140.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cartController.couponCode,
                                    style: fontRegularBold,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'YOU_SAVED'.tr + " ",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: 'Rubik'),
                                      ),
                                      if (widget.splashController.configData
                                              .siteCurrencyPosition ==
                                          5)
                                        Text(
                                          widget.splashController.configData
                                              .siteDefaultCurrencySymbol
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: 'Rubik'),
                                        ),
                                      Text(
                                        cartController.couponDiscount
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: 'Rubik'),
                                      ),
                                      if (widget.splashController.configData
                                              .siteCurrencyPosition ==
                                          10)
                                        Text(
                                          widget.splashController.configData
                                              .siteDefaultCurrencySymbol
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: 'Rubik'),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                          width: 40.w,
                          child: IconButton(
                            splashRadius: 20.r,
                            iconSize: 40.sp,
                            onPressed: () {
                              cartController.removeCoupon();
                            },
                            icon: SvgPicture.asset(
                              Images.iconTrash,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
