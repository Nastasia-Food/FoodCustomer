// ignore_for_file: sort_child_properties_last, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, unused_element, prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../../payment/views/payment_view.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/order_controller.dart';
import '../widget/stteper_widget_delivery.dart';
import '../widget/stteper_widget_takeaway.dart';

class OrderDetailsView extends StatefulWidget {
  final int? orderId;
  const OrderDetailsView({super.key, this.orderId});

  @override
  State<OrderDetailsView> createState() => _StatusViewViewState();
}

class _StatusViewViewState extends State<OrderDetailsView> {
  OrderController orderController = Get.put(OrderController());
  SplashController connect = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    connect.getConfiguration();
  }

  @override
  void dispose() {
    orderController.orderNotificationId.value = "null";
    orderController.activeStep.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      Get.put(OrderController());
      orderController
          .getOrderDetails(orderController.orderDetailsData.value.id!);
      super.initState();
    }

    return Obx(() {
      if (orderController.orderNotificationId.value.toString() ==
          orderController.orderDetailsData.value.id.toString()) {
        orderController.getOrderDetails(widget.orderId!);
        orderController.orderNotificationId.value = "";
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: -5.h,
          title: Text(
            'ORDER_STATUS'.tr,
            style: TextStyle(
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
        body: Stack(
          children: [
            RefreshIndicator(
              color: AppColor.primaryColor,
              onRefresh: () async {
                await orderController.getOrderDetails(
                    orderController.orderDetailsData.value.id!);
              },
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 60.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'ORDER_ID'.tr,
                                      style: fontMedium,
                                    ),
                                    Text(
                                      orderController
                                          .orderDetailsData.value.orderSerialNo
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w500,
                                          fontSize: Dimensions.fontSizeLarge.sp,
                                          color: AppColor.activeTxtColor),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  orderController
                                      .orderDetailsData.value.orderDatetime
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Rubik",
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 10.h,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 20.h, top: 10.h),
                                child: Obx(
                                  () => Column(
                                    children: [
                                      if (orderController.orderDetailsData.value.status != 13 &&
                                          orderController.orderDetailsData.value
                                                  .status !=
                                              16 &&
                                          orderController.orderDetailsData.value
                                                  .status !=
                                              22)
                                        Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                'ESTIMATED_DELIVERY_TIME'.tr,
                                                style: fontRegularBold,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                "${orderController.orderDetailsData.value.preparationTime} minutes"
                                                    .tr,
                                                style: TextStyle(
                                                  fontSize: 25.sp,
                                                  fontFamily: "Rubik",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (orderController
                                              .orderDetailsData.value.status ==
                                          13)
                                        Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "YOUR_ORDER_HAS_BEEN_DELIVERED"
                                                    .tr,
                                                style: TextStyle(
                                                  fontSize: 25.sp,
                                                  fontFamily: "Rubik",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (orderController
                                              .orderDetailsData.value.status ==
                                          16)
                                        Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "ORDER_HAS_BEEN_CANCELLED".tr,
                                                style: TextStyle(
                                                  fontSize: 22.sp,
                                                  fontFamily: "Rubik",
                                                  color: AppColor.error,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (orderController
                                              .orderDetailsData.value.status ==
                                          22)
                                        Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "ORDER_RETURNED".tr,
                                                style: TextStyle(
                                                  fontSize: 25.sp,
                                                  fontFamily: "Rubik",
                                                  color: AppColor.error,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (orderController
                                          .orderDetailsData.value.status ==
                                      1)
                                    Lottie.asset(Images.animationConfirmed,
                                        width: 120.w, height: 120.h),
                                  if (orderController
                                          .orderDetailsData.value.status ==
                                      4)
                                    Lottie.asset(Images.animationConfirmed,
                                        width: 120.w, height: 120.h),
                                  if (orderController
                                          .orderDetailsData.value.status ==
                                      7)
                                    Lottie.asset(Images.animationPreparing,
                                        width: 120.w, height: 120.h),
                                  if (orderController
                                          .orderDetailsData.value.status ==
                                      10)
                                    Lottie.asset(Images.animationProcessing,
                                        width: 120.w, height: 120.h),
                                  if (orderController
                                          .orderDetailsData.value.status ==
                                      13)
                                    Lottie.asset(Images.animationDelivered,
                                        width: 120.w, height: 120.h),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  orderController.orderDetailsData.value
                                                  .status !=
                                              16 &&
                                          orderController.orderDetailsData.value
                                                  .status !=
                                              22
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'GOT_YOUR_ORDER'.tr,
                                              style: fontRegularBold,
                                            ),
                                            Text(
                                              '${orderController.orderDetailsData.value.user!.firstName}',
                                              style: fontRegularBold,
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                  orderController.orderDetailsData.value
                                                  .status !=
                                              16 &&
                                          orderController.orderDetailsData.value
                                                  .status !=
                                              22
                                      ? SizedBox(
                                          child: orderController
                                                      .orderDetailsData
                                                      .value
                                                      .orderType ==
                                                  5
                                              ? StepperWidgetDelivery()
                                              : StepperWidgetTakeAway(),
                                        )
                                      : SizedBox()
                                ],
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderController
                                          .orderDetailsData.value.branch!.name!,
                                      style: fontBold,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    orderController.orderDetailsData.value
                                                .orderType ==
                                            5
                                        ? Text("DELIVERY".tr,
                                            style: fontRegular)
                                        : Text("TAKEAWAY".tr,
                                            style: fontRegular),
                                  ],
                                ),
                                Row(
                                  children: [
                                    if (orderController
                                            .orderDetailsData.value.orderType ==
                                        10)
                                      InkWell(
                                        onTap: () async {
                                          if (await MapLauncher.isMapAvailable(
                                                  MapType.google) !=
                                              null) {
                                            MapLauncher.showDirections(
                                                mapType: MapType.google,
                                                destination: Coords(
                                                    double.parse(orderController
                                                        .orderDetailsData
                                                        .value
                                                        .branch!
                                                        .latitude!),
                                                    double.parse(orderController
                                                        .orderDetailsData
                                                        .value
                                                        .branch!
                                                        .longitude!)));
                                          }
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 35.w,
                                          decoration: BoxDecoration(
                                              color: AppColor.viewAllbg,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SvgPicture.asset(
                                              Images.iconMap,
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () async {
                                        final call = Uri.parse(
                                            'tel:${Get.find<SplashController>().countryInfoData.callingCode! + orderController.orderDetailsData.value.branch!.phone.toString()}');
                                        if (await canLaunchUrl(call)) {
                                          launchUrl(call);
                                        } else {
                                          throw 'Could not launch $call';
                                        }
                                      },
                                      child: Container(
                                        height: 35.h,
                                        width: 35.w,
                                        decoration: BoxDecoration(
                                            color: AppColor.viewAllbg,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SvgPicture.asset(
                                            Images.call,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 24.h,
                          ),
                          //payment information
                          Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PAYMENT_INFO'.tr,
                                  style: fontMedium,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'METHOD'.tr,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: "Rubik",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    ),
                                    if (orderController.orderDetailsData.value
                                                .orderType ==
                                            5 &&
                                        orderController.orderDetailsData.value
                                                .transaction ==
                                            null)
                                      Text(
                                        "CASH_ON_DELIVERY".tr,
                                        style: TextStyle(
                                          fontFamily: "Rubik",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    if (orderController.orderDetailsData.value
                                                .orderType ==
                                            10 &&
                                        orderController.orderDetailsData.value
                                                .transaction ==
                                            null)
                                      Text(
                                        "PICK_AND_PAY".tr,
                                        style: TextStyle(
                                          fontFamily: "Rubik",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    if (orderController.orderDetailsData.value
                                            .transaction !=
                                        null)
                                      Text(
                                        orderController.orderDetailsData.value
                                            .transaction!.paymentMethod
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: "Rubik",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'STATUS'.tr,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: "Rubik",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    ),
                                    if (orderController.orderDetailsData.value
                                            .paymentStatus ==
                                        5)
                                      Text(
                                        'PAID'.tr,
                                        style: TextStyle(
                                            fontFamily: "Rubik",
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.success),
                                      ),
                                    if (orderController.orderDetailsData.value
                                            .paymentStatus ==
                                        10)
                                      Text(
                                        'UNPAID'.tr,
                                        style: TextStyle(
                                            fontFamily: "Rubik",
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.error),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ),
                          //cart summary section
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.w, right: 16.w, bottom: 20.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.itembg,
                                    offset: const Offset(
                                      0.0,
                                      0.0,
                                    ),
                                    blurRadius: 5.0.r,
                                    spreadRadius: 1.0.r,
                                  ),
                                  //BoxShadow
                                  //BoxShadow
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      "ORDER_DETAILS".tr,
                                      style: fontMedium,
                                    ),
                                  ),
                                  ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: orderController.orderDetailsData
                                        .value.orderItems!.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          left: 8.w,
                                          right: 8.w,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 65.h,
                                              child: Row(children: [
                                                Stack(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.w,
                                                          right: 8.w),
                                                      child: SizedBox(
                                                        width: 70.w,
                                                        height: 70.h,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8.r)),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: orderController
                                                                .orderDetailsData
                                                                .value
                                                                .orderItems![
                                                                    index]
                                                                .itemImage!,
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            placeholder: (context,
                                                                    url) =>
                                                                Shimmer
                                                                    .fromColors(
                                                              child: Container(
                                                                  height: 130,
                                                                  width: 200,
                                                                  color: Colors
                                                                      .grey),
                                                              baseColor: Colors
                                                                  .grey[300]!,
                                                              highlightColor:
                                                                  Colors.grey[
                                                                      400]!,
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 22.h,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20.r), //or 15.0
                                                        child: Container(
                                                          height: 20.h,
                                                          width: 20.w,
                                                          color: AppColor
                                                              .fontColor,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              orderController
                                                                  .orderDetailsData
                                                                  .value
                                                                  .orderItems![
                                                                      index]
                                                                  .quantity!
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 200.w,
                                                  child: FittedBox(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          orderController
                                                              .orderDetailsData
                                                              .value
                                                              .orderItems![
                                                                  index]
                                                              .itemName!,
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        orderController
                                                                    .orderDetailsData
                                                                    .value
                                                                    .orderItems![
                                                                        index]
                                                                    .itemVariations !=
                                                                null
                                                            ? SizedBox(
                                                                width: 240.w,
                                                                height: 20.h,
                                                                child: ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: orderController
                                                                      .orderDetailsData
                                                                      .value
                                                                      .orderItems![
                                                                          index]
                                                                      .itemVariations!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          i) {
                                                                    return Text(
                                                                      index ==
                                                                              orderController.orderDetailsData.value.orderItems![index].itemVariations!.length - 1
                                                                          ? "${orderController.orderDetailsData.value.orderItems![index].itemVariations![i].variationName} : ${orderController.orderDetailsData.value.orderItems![index].itemVariations![i].name}."
                                                                          : "${orderController.orderDetailsData.value.orderItems![index].itemVariations![i].variationName} : ${orderController.orderDetailsData.value.orderItems![index].itemVariations![i].name}, ",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Rubik',
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              AppColor.gray),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          2,
                                                                    );
                                                                  },
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                        SizedBox(
                                                          height: 4.h,
                                                        ),
                                                        Text(
                                                          orderController
                                                              .orderDetailsData
                                                              .value
                                                              .orderItems![
                                                                  index]
                                                              .price!
                                                              .toString(),
                                                          style: fontMediumPro,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.w),
                                              child:
                                                  orderDetailsVariationSection(
                                                      index),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.w),
                                              child:
                                                  orderItemInstructionSection(
                                                      index),
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 12.w,
                                        right: 12.w,
                                        top: 16.h,
                                        bottom: 12.h),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border: Border.all(
                                              color: AppColor.itembg)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0.r),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'SUBTOTAL'.tr,
                                                  style: fontRegularLite,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  orderController
                                                      .orderDetailsData
                                                      .value
                                                      .subtotalCurrencyPrice
                                                      .toString(),
                                                  style: fontRegularLite,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0.r),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'DISCOUNT'.tr,
                                                  style: fontRegularLite,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  orderController
                                                      .orderDetailsData
                                                      .value
                                                      .discountCurrencyPrice
                                                      .toString(),
                                                  style: fontRegularLite,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0.r),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'DELIVERY_CHARGE'.tr,
                                                  style: fontRegularLite,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  orderController
                                                      .orderDetailsData
                                                      .value
                                                      .deliveryChargeCurrencyPrice
                                                      .toString(),
                                                  style: fontRegularBoldGreen,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: AppColor.gray
                                                    .withOpacity(0.2),
                                                overflow: TextOverflow.fade),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0.r),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'TOTAL'.tr,
                                                  style: fontRegularBold,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  orderController
                                                      .orderDetailsData
                                                      .value
                                                      .totalCurrencyPrice
                                                      .toString(),
                                                  style: fontRegularBold,
                                                ),
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
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.itembg.withOpacity(1),
                            offset: const Offset(
                              6.0,
                              0.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 3,
                          ), //BoxShadow
                          //BoxShadow
                        ],
                      ),
                      child: SizedBox(
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (orderController.orderDetailsData.value
                                            .paymentStatus !=
                                        5 &&
                                    orderController
                                            .orderDetailsData.value.status !=
                                        16 &&
                                    connect.configData.siteOnlinePaymentGateway
                                            .toString() ==
                                        '5')
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.w, right: 4.w),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => PaymentView(
                                                orderId: widget.orderId,
                                              ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              AppColor.primaryColor,
                                          minimumSize: Size(156.w, 48.h),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.r),
                                          ),
                                        ),
                                        child: Text(
                                          "PAY_NOW".tr,
                                          style: fontMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (orderController
                                        .orderDetailsData.value.status ==
                                    1)
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.w, right: 4.w),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            AlertDialog(
                                                content: SizedBox(
                                              height: 160,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "ARE_YOU_SURE_TO_CANCEL_THIS_ORDER"
                                                          .tr
                                                          .tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: fontMedium,
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              elevation: 1,
                                                              backgroundColor:
                                                                  AppColor
                                                                      .itembg,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24.r),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              "No".tr,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColor
                                                                    .primaryColor,
                                                                fontSize: 15.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Get.back();
                                                              orderController
                                                                  .orderCancel(
                                                                      orderController
                                                                          .orderDetailsData
                                                                          .value
                                                                          .id);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              elevation: 1,
                                                              backgroundColor:
                                                                  AppColor
                                                                      .primaryColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24.r),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              "Yes".tr,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                            barrierDismissible: false,
                                          );
                                          // orderController.orderCancel(
                                          //     orderController
                                          //         .orderDetailsData.id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              AppColor.deleteBtnColor,
                                          minimumSize: Size(156.w, 48.h),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.r),
                                          ),
                                        ),
                                        child: Text(
                                          "CANCEL_ORDER".tr,
                                          style: fontMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            orderController.orderDetailsLoader.value
                ? Positioned(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white60,
                      child: const Center(
                        child: LoaderCircle(),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );
    });
  }
}

Widget orderItemInstructionSection(int i) {
  final orderController = Get.find<OrderController>();
  return Column(
    children: [
      orderController.orderDetailsData.value.orderItems![i].instruction !=
                  null &&
              orderController
                  .orderDetailsData.value.orderItems![i].instruction!.isNotEmpty
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "INSTRUCTION".tr + ' : ',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: Get.width - 160,
                  child: Text(
                    orderController
                        .orderDetailsData.value.orderItems![i].instruction
                        .toString(),
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.gray),
                  ),
                )
              ],
            )
          : const SizedBox.shrink(),
    ],
  );
}

Widget orderDetailsVariationSection(int i) {
  final orderController = Get.find<OrderController>();
  return Padding(
    padding: EdgeInsets.only(
      top: 8.h,
    ),
    child: Column(
      children: [
        orderController.orderDetailsData.value.orderItems![i].itemExtras !=
                    null &&
                orderController.orderDetailsData.value.orderItems![i]
                    .itemExtras!.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(bottom: 4.h, right: 8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EXTRAS".tr,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 240.w,
                      height: 15.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: orderController.orderDetailsData.value
                            .orderItems![i].itemExtras!.length,
                        itemBuilder: (BuildContext context, index) {
                          return Text(
                            index ==
                                    orderController.orderDetailsData.value
                                            .orderItems![i].itemExtras!.length -
                                        1
                                ? "${orderController.orderDetailsData.value.orderItems![i].itemExtras![index].name}."
                                : "${orderController.orderDetailsData.value.orderItems![i].itemExtras![index].name},",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.gray),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}
