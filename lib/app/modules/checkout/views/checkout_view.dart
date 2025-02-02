// ignore_for_file: prefer_const_constructors_in_immutables, sort_child_properties_last, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, deprecated_member_use

import 'dart:collection';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../../widget/custom_toast.dart';
import '../../../../widget/loader.dart';
import '../../../data/model/body/place_order_body.dart';
import '../../../data/model/response/order_details_model.dart';
import '../../address/widget/addAddress/add_pick_location_view.dart';
import '../../address/widget/editAddress/edit_pick_location_view.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/widgets/cart_instruction_widget.dart';
import '../../cart/widgets/cart_variation_widget.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../home/controllers/home_controller.dart';
import '../../address/controllers/address_controller.dart';
import '../../order/controllers/order_controller.dart';
import '../../payment/views/payment_view.dart';
import '../../profile/widget/location_permission_dialouge.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/checkout_controller.dart';
import '../controllers/coupon_controller.dart';
import '../controllers/order_controller.dart';
import 'package:lottie/lottie.dart' as lottie;
import '../widget/apply_offer_card_widget.dart';
import '../widget/order_confirm_dialog_button.dart';
import '../widget/time_slot_widget.dart';

class CheckoutView extends StatefulWidget {
  final int? orderId;
  CheckoutView({Key? key, this.orderId}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  GoogleMapController? _mapController;

  SplashController connect = Get.put(SplashController());

  Set<Marker> _markers = HashSet<Marker>();

  bool maploading = true;

  double branchLat = 0.0;
  double branchLong = 0.0;
  double addressLat = 0.0;
  double addressLon = 0.0;

  bool isActive = true;
  String selectedDate = '';
  int isAdvanceOrder = 10;

  @override
  void initState() {
    super.initState();
    HomeController homeController = Get.put(HomeController());
    AddressController addressController = Get.put(AddressController());
    CartController cartController = Get.put(CartController());
    CheckoutController checkoutController = Get.put(CheckoutController());
    SplashController splashController = Get.put(SplashController());
    addressController.getAddressList();
    connect.getConfiguration();

    // if (addressController.addressDataList.isNotEmpty) {
    //   addressController.setAddress(0);
    //   addressLat = double.parse(
    //       addressController.addressDataList[0].latitude.toString());
    //   addressLon = double.parse(
    //       addressController.addressDataList[0].longitude.toString());
    //   Get.find<CartController>().distanceWiseDeliveryCharge();
    //   Get.find<CartController>().calculateTotal();
    // }

    if (addressController.addressDataList.isNotEmpty) {
      addressLat = double.parse(
          addressController.addressDataList[0].latitude.toString());
      addressLon = double.parse(
          addressController.addressDataList[0].longitude.toString());
    }

    if (homeController.branchDataList.isNotEmpty) {
      branchLat = double.parse(homeController
          .branchDataList[homeController.selectedBranchIndex].latitude
          .toString());
      branchLong = double.parse(homeController
          .branchDataList[homeController.selectedBranchIndex].longitude
          .toString());
    }

    cartController.calculateDistance(
        addressLat, addressLon, branchLat, branchLong);
    if (checkoutController.todayDataList.isNotEmpty) {
      selectedDate = checkoutController.todayDataList[0].time!;
      isAdvanceOrder = 10;
    }

    if (splashController.configData.orderSetupDelivery == 10 &&
        splashController.configData.orderSetupTakeaway == 5) {
      cartController.orderTypeIndex = 1;
    }
    if (splashController.configData.orderSetupDelivery == 10 &&
        splashController.configData.orderSetupTakeaway == 10) {
      cartController.orderTypeIndex = 10;
    }

    addressController.selectedAddress = null;
  }

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    AddressController addressController = Get.put(AddressController());
    HomeController homeController = Get.put(HomeController());
    SplashController splashController = Get.put(SplashController());

    return GetBuilder<PlaceOrderController>(
      builder: (placeOrderController) => Stack(
        children: [
          Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                titleSpacing: -5,
                title: Text(
                  'CHECKOUT'.tr,
                  style: fontBoldWithColorBlack,
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
                  SizedBox(
                    height: Get.height,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          homeController.branchDataList.length != 1
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.w, right: 16.w),
                                      child: Row(
                                        children: [
                                          Text(
                                            "SELECT_BRUNCH".tr,
                                            style: fontMedium,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.h, right: 16.w),
                                      child: SizedBox(
                                        height: 50.h,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ListView.builder(
                                                      primary: false,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemCount: homeController
                                                          .branchDataList
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            homeController
                                                                    .selectedBranch =
                                                                homeController
                                                                    .branchDataList[
                                                                        index]
                                                                    .name;
                                                            homeController
                                                                    .selectedbranchId =
                                                                homeController
                                                                    .branchDataList[
                                                                        index]
                                                                    .id!;
                                                            homeController
                                                                    .selectedBranchIndex =
                                                                index;

                                                            branchLat = double.parse(
                                                                homeController
                                                                    .branchDataList[
                                                                        index]
                                                                    .latitude
                                                                    .toString());

                                                            branchLong = double
                                                                .parse(homeController
                                                                    .branchDataList[
                                                                        index]
                                                                    .longitude
                                                                    .toString());

                                                            Get.find<
                                                                    CartController>()
                                                                .calculateDistance(
                                                                    addressLat,
                                                                    addressLon,
                                                                    branchLat,
                                                                    branchLong);
                                                            _setMarkers();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 16.w),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                                color: index ==
                                                                        homeController
                                                                            .selectedBranchIndex
                                                                    ? AppColor
                                                                        .primaryColor
                                                                    : Colors
                                                                        .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: AppColor
                                                                        .itembg,
                                                                    offset:
                                                                        const Offset(
                                                                      0.0,
                                                                      4.0,
                                                                    ),
                                                                    blurRadius:
                                                                        5.0.r,
                                                                    spreadRadius:
                                                                        0.5.r,
                                                                  ),
                                                                  const BoxShadow(
                                                                    color: AppColor
                                                                        .itembg,
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                    blurRadius:
                                                                        1.0,
                                                                    spreadRadius:
                                                                        0.1,
                                                                  ), //BoxShadow
                                                                  //BoxShadow
                                                                ],
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8.0
                                                                            .r),
                                                                child: SizedBox(
                                                                  height: 32.h,
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    homeController
                                                                        .branchDataList[
                                                                            index]
                                                                        .name!,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Rubik',
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight: index ==
                                                                              homeController
                                                                                  .selectedBranchIndex
                                                                          ? FontWeight
                                                                              .w500
                                                                          : FontWeight
                                                                              .w400,
                                                                      color: index ==
                                                                              homeController
                                                                                  .selectedBranchIndex
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
                                                                    ),
                                                                  )),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          //branch map
                          homeController.branchDataList.length != 1
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.w,
                                          right: 16.w,
                                          top: 16.h,
                                          bottom: 16.h),
                                      child: SizedBox(
                                        height: 140.h,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Stack(
                                            children: [
                                              GoogleMap(
                                                initialCameraPosition: CameraPosition(
                                                    target: LatLng(
                                                        double.parse(homeController
                                                            .branchDataList[
                                                                homeController
                                                                    .selectedBranchIndex]
                                                            .latitude!),
                                                        double.parse(homeController
                                                            .branchDataList[
                                                                homeController
                                                                    .selectedBranchIndex]
                                                            .longitude!)),
                                                    zoom: 17),
                                                minMaxZoomPreference:
                                                    const MinMaxZoomPreference(
                                                        0, 16),
                                                compassEnabled: false,
                                                indoorViewEnabled: true,
                                                mapToolbarEnabled: false,
                                                zoomControlsEnabled: true,
                                                // markers: _markers,
                                                onMapCreated:
                                                    (GoogleMapController
                                                        controller) async {
                                                  await Geolocator
                                                      .requestPermission();
                                                  _mapController = controller;
                                                  maploading = false;
                                                  _setMarkers();
                                                },
                                              ),
                                              Center(
                                                  child: Image.asset(
                                                      Images.markerBranch,
                                                      height: 50.h,
                                                      width: 50.w)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (cartController.orderTypeIndex == 1)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16.w,
                                            right: 16.w,
                                            bottom: 30.h),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              Images.locationIcon,
                                              fit: BoxFit.cover,
                                              height: 18.h,
                                              width: 18.h,
                                              color: AppColor.primaryColor,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            SizedBox(
                                              width: Get.width - 55.w,
                                              child: Text(
                                                homeController
                                                    .branchDataList[
                                                        homeController
                                                            .selectedBranchIndex]
                                                    .address!,
                                                style: fontProfileLite,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                )
                              : const SizedBox.shrink(),

                          // delivaryAddressSection(context),
                          if (cartController.orderTypeIndex == 0)
                            GetBuilder<AddressController>(
                              builder: (addressController) => Padding(
                                padding: EdgeInsets.only(
                                    left: 16.w, right: 16.w, bottom: 24.h),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 32.h,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "DELIVERY_ADDRESS".tr,
                                              style: fontMedium,
                                            ),
                                            Row(
                                              children: [
                                                addressController
                                                        .addressDataList
                                                        .isNotEmpty
                                                    ? Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 12.r,
                                                                right: 12.r,
                                                                top: 8.r,
                                                                bottom: 8.r),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.r),
                                                          color: AppColor
                                                              .blueTransparent,
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.to(() =>
                                                                EditPickLocationView(
                                                                  addressData: addressController
                                                                          .addressDataList[
                                                                      addressController
                                                                          .selectedAddress!],
                                                                ));
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                Images.iconEdit,
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 13.h,
                                                                width: 13.h,
                                                              ),
                                                              SizedBox(
                                                                width: 3.w,
                                                              ),
                                                              Text(
                                                                "EDIT".tr,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Rubik',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall
                                                                          .sp,
                                                                  color: AppColor
                                                                      .blueTextColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                SizedBox(
                                                  width: 12.w,
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                      left: 12.r,
                                                      right: 12.r,
                                                      top: 8.r,
                                                      bottom: 8.r),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                    color: AppColor.viewAllbg,
                                                  ),
                                                  child: InkWell(
                                                    onTap: () =>
                                                        _checkPermission(
                                                            () async {
                                                      Get.to(
                                                          AddPickLocationView());
                                                    }),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          Images.iconAdd,
                                                          fit: BoxFit.cover,
                                                          height: 13.h,
                                                          width: 13.h,
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Text(
                                                          "ADD".tr,
                                                          style:
                                                              fontRegularBoldwithColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    addressController.addressDataList.isNotEmpty
                                        ? Container(
                                            alignment: Alignment.centerLeft,
                                            height: 100.h,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: addressController
                                                    .addressDataList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          addressController
                                                              .setAddress(
                                                                  index);
                                                          addressLat = double.parse(
                                                              addressController
                                                                  .addressDataList[
                                                                      index]
                                                                  .latitude
                                                                  .toString());
                                                          addressLon = double.parse(
                                                              addressController
                                                                  .addressDataList[
                                                                      index]
                                                                  .longitude
                                                                  .toString());
                                                          Get.find<
                                                                  CartController>()
                                                              .calculateDistance(
                                                                  addressLat,
                                                                  addressLon,
                                                                  branchLat,
                                                                  branchLong);
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 80.h,
                                                        width: 158.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                          color: addressController
                                                                      .selectedAddress ==
                                                                  index
                                                              ? AppColor
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.08)
                                                              : AppColor.itembg,
                                                          border: addressController
                                                                      .selectedAddress ==
                                                                  index
                                                              ? Border.all(
                                                                  color: AppColor
                                                                      .primaryColor)
                                                              : Border.all(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 130.w,
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                8.w,
                                                                            left: 8.w,
                                                                            right: 8.h),
                                                                        child: addressController.addressDataList[index].label.toString() ==
                                                                                "Home"
                                                                            ? SvgPicture.asset(
                                                                                Images.homeIcon,
                                                                                fit: BoxFit.cover,
                                                                                height: 15.h,
                                                                                width: 15.w,
                                                                              )
                                                                            : addressController.addressDataList[index].label.toString() == "Office"
                                                                                ? SvgPicture.asset(
                                                                                    Images.work,
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                : SvgPicture.asset(
                                                                                    Images.other,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 8.h),
                                                                        child:
                                                                            Text(
                                                                          addressController
                                                                              .addressDataList[index]
                                                                              .label
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Rubik',
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                Dimensions.fontSizeDefault,
                                                                            color:
                                                                                AppColor.blueTextColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              2,
                                                                          right:
                                                                              2),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 20.w,
                                                                    height:
                                                                        20.h,
                                                                    child: addressController.selectedAddress ==
                                                                            index
                                                                        ? SvgPicture
                                                                            .asset(
                                                                            Images.IconVariationSelected,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : SvgPicture
                                                                            .asset(
                                                                            Images.IconVariation,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                8.h,
                                                                            left: 8.w,
                                                                            right: 8.w),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          Images
                                                                              .locationIcon,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 8.h),
                                                                          child:
                                                                              Text(
                                                                            addressController.addressDataList[index].address.toString(),
                                                                            style:
                                                                                fontRegular,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            addressController
                                                                        .addressDataList[
                                                                            index]
                                                                        .apartment !=
                                                                    null
                                                                ? Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 28),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Flexible(
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(top: 8.h),
                                                                                  child: Text(
                                                                                    addressController.addressDataList[index].apartment.toString(),
                                                                                    style: fontRegular,
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : const SizedBox(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Get.to(AddPickLocationView());
                                            },
                                            child: Container(
                                              height: 60.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  color: AppColor.primaryColor
                                                      .withOpacity(0.08),
                                                  border: Border.all(
                                                      color: AppColor
                                                          .primaryColor)),
                                              child: Center(
                                                  child: Text(
                                                "PLEASE_ADD_DELIVERY_ADDRESS"
                                                    .tr,
                                                style: fontRegularBold,
                                              )),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),

                          //preference time to delivery
                          GetBuilder<CheckoutController>(
                            builder: (checkoutController) => Padding(
                              padding: EdgeInsets.only(
                                  left: 16.w, bottom: 24.w, right: 8.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: Text(
                                          "PREFERENCE_TIME_TO_DELIVERY".tr,
                                          style: fontMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 40.h,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: 2,
                                            itemBuilder: (context, index) {
                                              return TimeSlotWidget(
                                                title: index == 0
                                                    ? 'TODAY'.tr
                                                    : 'TOMORROW'.tr,
                                                isSelected: checkoutController
                                                        .selectDateSlot ==
                                                    index,
                                                onTap: () {
                                                  checkoutController
                                                      .updateDateSlot(index);
                                                },
                                              );
                                            }),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  if (checkoutController.selectDateSlot == 0)
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        height: 40.h,
                                        child: checkoutController
                                                    .todayDataList !=
                                                null
                                            ? checkoutController
                                                    .todayDataList.isNotEmpty
                                                ? ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemCount:
                                                        checkoutController
                                                            .todayDataList
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return TimeSlotWidget(
                                                        title: (index == 0 &&
                                                                checkoutController
                                                                        .selectDateSlot ==
                                                                    0
                                                            ? 'NOW'.tr
                                                            : checkoutController
                                                                .todayDataList[
                                                                    index]
                                                                .label!),
                                                        isSelected:
                                                            checkoutController
                                                                    .selectTimeSlot ==
                                                                index,
                                                        onTap: () {
                                                          selectedDate =
                                                              checkoutController
                                                                  .todayDataList[
                                                                      index]
                                                                  .time!;
                                                          isAdvanceOrder = 10;
                                                          checkoutController
                                                              .updateTimeSlot(
                                                                  index);
                                                        },
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    height: 60.h,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        color: AppColor
                                                            .primaryColor
                                                            .withOpacity(0.08),
                                                        border: Border.all(
                                                            color: AppColor
                                                                .primaryColor)),
                                                    child: Center(
                                                        child: Text(
                                                      "CURRENTLY_NOT_ACCEPTING_ANY_ORDER"
                                                          .tr,
                                                      style: fontRegularBold,
                                                    )),
                                                  )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator())),
                                  if (checkoutController.selectDateSlot == 1)
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        height: 40.h,
                                        child: checkoutController
                                                    .tomorrowDataList !=
                                                null
                                            ? checkoutController
                                                    .tomorrowDataList.isNotEmpty
                                                ? ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemCount:
                                                        checkoutController
                                                            .tomorrowDataList
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return TimeSlotWidget(
                                                        title: checkoutController
                                                            .tomorrowDataList[
                                                                index]
                                                            .label!,
                                                        isSelected:
                                                            checkoutController
                                                                    .selectTimeSlot ==
                                                                index,
                                                        onTap: () {
                                                          selectedDate =
                                                              checkoutController
                                                                  .tomorrowDataList[
                                                                      index]
                                                                  .time!;
                                                          isAdvanceOrder = 5;
                                                          checkoutController
                                                              .updateTimeSlot(
                                                                  index);
                                                        },
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    height: 60.h,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        color: AppColor
                                                            .primaryColor
                                                            .withOpacity(0.08),
                                                        border: Border.all(
                                                            color: AppColor
                                                                .primaryColor)),
                                                    child: Center(
                                                        child: Text(
                                                      "NOT_ACCEPTING_ANY_ORDER"
                                                          .tr,
                                                      style: fontRegularBold,
                                                    )),
                                                  )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator())),
                                ],
                              ),
                            ),
                          ),

                          // PaymentMethodSection(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                top: 10.h,
                                bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "CART_SUMMARY".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (splashController
                                            .configData.orderSetupDelivery ==
                                        5 &&
                                    splashController
                                            .configData.orderSetupTakeaway ==
                                        5)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      child: ToggleSwitch(
                                        minWidth: 90.w,
                                        cornerRadius: 20.r,
                                        activeBgColors: const [
                                          [AppColor.delivaryActive],
                                          [AppColor.delivaryActive],
                                        ],
                                        activeFgColor: Colors.white,
                                        inactiveBgColor:
                                            AppColor.delivaryInactive,
                                        inactiveFgColor: Colors.white,
                                        initialLabelIndex:
                                            cartController.orderTypeIndex,
                                        customTextStyles: [fontMediumProWhite],
                                        totalSwitches: 2,
                                        labels: ['DELIVERY'.tr, 'TAKEAWAY'.tr],
                                        radiusStyle: true,
                                        onToggle: (index) {
                                          setState(() {
                                            cartController.orderTypeIndex =
                                                index!;
                                            cartController
                                                .distanceWiseDeliveryCharge();
                                            cartController.calculateTotal();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                if (splashController
                                            .configData.orderSetupDelivery ==
                                        5 &&
                                    splashController
                                            .configData.orderSetupTakeaway ==
                                        10)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      child: ToggleSwitch(
                                        minWidth: 90.w,
                                        cornerRadius: 20.r,
                                        activeBgColors: const [
                                          [AppColor.delivaryActive],
                                        ],
                                        activeFgColor: Colors.white,
                                        inactiveBgColor:
                                            AppColor.delivaryInactive,
                                        inactiveFgColor: Colors.white,
                                        initialLabelIndex:
                                            cartController.orderTypeIndex,
                                        customTextStyles: [fontMediumProWhite],
                                        totalSwitches: 1,
                                        labels: ['DELIVERY'.tr],
                                        radiusStyle: true,
                                      ),
                                    ),
                                  ),
                                if (splashController
                                            .configData.orderSetupDelivery ==
                                        10 &&
                                    splashController
                                            .configData.orderSetupTakeaway ==
                                        5)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      child: ToggleSwitch(
                                        minWidth: 90.w,
                                        cornerRadius: 20.r,
                                        activeBgColors: const [
                                          [AppColor.delivaryActive],
                                        ],
                                        activeFgColor: Colors.white,
                                        inactiveBgColor:
                                            AppColor.delivaryInactive,
                                        inactiveFgColor: Colors.white,
                                        initialLabelIndex:
                                            cartController.orderTypeIndex,
                                        customTextStyles: [fontMediumProWhite],
                                        totalSwitches: 1,
                                        labels: ['TAKEAWAY'.tr],
                                        radiusStyle: true,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          cartSummarySection(context),
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
                            spreadRadius: 2,
                          ), //BoxShadow
                          //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16),
                        child: GetBuilder<PlaceOrderController>(
                          builder: (placeOrderController) => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    if (splashController.configData
                                                .orderSetupDelivery ==
                                            10 &&
                                        splashController.configData
                                                .orderSetupTakeaway ==
                                            10) {
                                      customTast(
                                          "CURRENTLY_NOT_ACCEPTING_ANY_ORDER"
                                              .tr,
                                          AppColor.error);
                                    } else if (addressController
                                            .addressDataList.isEmpty &&
                                        cartController.orderTypeIndex == 0) {
                                      customTast(
                                          "PLEASE_ADD_DELIVERY_ADDRESS".tr,
                                          AppColor.error);
                                    } else if (addressController
                                                .selectedAddress ==
                                            null &&
                                        cartController.orderTypeIndex == 0) {
                                      customTast("PLEASE_CHOOSE_AN_ADDRESS".tr,
                                          AppColor.error);
                                    } else {
                                      placeOrderController.placeOrderPost(
                                          PlaceOrderBody(
                                            branchId:
                                                homeController.selectedbranchId,
                                            orderType:
                                                cartController.orderTypeIndex ==
                                                        0
                                                    ? 5
                                                    : 10,
                                            isAdvanceOrder: isAdvanceOrder,
                                            deliveryCharge:
                                                cartController.deliveryCharge,
                                            distance: cartController.kilometer,
                                            addressId: cartController
                                                        .orderTypeIndex ==
                                                    0
                                                ? addressController
                                                    .addressDataList[
                                                        addressController
                                                            .selectedAddress!]
                                                    .id
                                                : null,
                                            deliveryTime: selectedDate,
                                            subtotal:
                                                cartController.totalCartValue,
                                            total: cartController.total,
                                            couponId: cartController.couponId,
                                            discount:
                                                cartController.couponDiscount,
                                            source: 10,
                                            items: cartController.cart,
                                          ),
                                          callback);
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColor.primaryColor,
                                  minimumSize: Size(328.w, 52.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                ),
                                child: Text(
                                  "PLACE_ORDER".tr,
                                  style: fontMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          placeOrderController.loader
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
  }

  _setMarkers() async {
    // ignore: unused_local_variable
    BitmapDescriptor _bitmapDescriptor;
    // ignore: unused_local_variable
    BitmapDescriptor _bitmapDescriptorUnSelect;
    // Uint8List activeImageData = await convertAssetToUnit8List(Images.restaurant_marker, width: ResponsiveHelper.isMobilePhone() ? 30 : 30);
    // Uint8List inactiveImageData = await convertAssetToUnit8List(Images.unselected_restaurant_marker, width: ResponsiveHelper.isMobilePhone() ? 30 : 30);
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(30, 50)), Images.marker)
        .then((_marker) {
      _bitmapDescriptor = _marker;
    });
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(20, 20)), Images.marker)
        .then((_marker) {
      _bitmapDescriptorUnSelect = _marker;
    });
    // Marker
    _markers = HashSet<Marker>();
    for (int index = 0;
        index < Get.find<HomeController>().branchDataList.length;
        index++) {
      _markers.add(Marker(
        markerId: MarkerId('branch_$index'),
        position: LatLng(
            double.parse(
                Get.find<HomeController>().branchDataList[index].latitude!),
            double.parse(
                Get.find<HomeController>().branchDataList[index].longitude!)),
      ));
    }
    _mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            double.parse(Get.find<HomeController>()
                .branchDataList[Get.find<HomeController>().selectedBranchIndex]
                .latitude!),
            double.parse(Get.find<HomeController>()
                .branchDataList[Get.find<HomeController>().selectedBranchIndex]
                .longitude!)),
        zoom: 16)));
    setState(() {});
  }

  void callback(bool isSuccess, OrderDetailsData orderDetailsData) {
    if (isSuccess) {
      Get.offAll(() => const DashboardView());
      confirmAlert(context, orderDetailsData).show();
    }
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      customSnackbar("ERROR".tr, "LOCATION_SERVICE_DENIED".tr, AppColor.error);
    } else if (permission == LocationPermission.deniedForever) {
      permissionAlert(context).show();
    } else {
      onTap();
    }
  }

  confirmAlert(BuildContext context, OrderDetailsData orderDetaislData) {
    return Alert(
      closeIcon: InkWell(
        onTap: () {
          Get.back();
        },
        child: Image.asset(
          Images.closeCircle,
          fit: BoxFit.cover,
          height: 20.h,
          width: 20.w,
        ),
      ),
      style: AlertStyle(
        animationType: AnimationType.grow,
        descStyle: fontMedium,
        descTextAlign: TextAlign.center,
        animationDuration: const Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        alertAlignment: Alignment.center,
      ),
      context: context,
      content: Column(children: [
        Text(
          "THANK_YOU_FOR_YOUR_ORDER".tr,
          style: fontMedium,
        ),
        lottie.Lottie.asset(
          Images.animationConfirmed,
          height: 120.h,
          width: 120.w,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "ORDER_CONFIRMED".tr,
          style: fontBoldWithColor,
        ),
        const SizedBox(
          height: 12,
        ),
        if (orderDetaislData.orderType.toString() == "5")
          connect.configData.siteOnlinePaymentGateway.toString() == '5'
              ? Text(
                  "CONFIRMED_COD_1".tr,
                  style: fontRegular,
                )
              : Text(
                  "CONFIRMED_COD".tr,
                  style: fontRegular,
                ),
        if (orderDetaislData.orderType.toString() == "10")
          Text(
            "CONFIRMED_PNP".tr,
            style: fontRegular,
          ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderDetaislData.branch!.name!,
                  style: fontMediumPro,
                ),
                SizedBox(
                  height: 6.h,
                ),
                SizedBox(
                  height: 6.h,
                ),
                orderDetaislData.orderType.toString() == "5"
                    ? Text("DELIVERY".tr, style: fontRegular)
                    : Text("TAKEAWAY".tr, style: fontRegular),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    final call = Uri.parse(
                        'tel:${Get.find<SplashController>().countryInfoData.callingCode! + orderDetaislData.branch!.phone.toString()}');
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
                        borderRadius: BorderRadius.circular(100)),
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
        SizedBox(height: 20.h),
        connect.configData.siteOnlinePaymentGateway.toString() == '5'
            ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                OrderConfirmDialogButton(
                    height: 48.h,
                    width: 110.w,
                    text: "GO_TO_ORDER_DETAILS".tr,
                    textSize: 14.sp,
                    textColor: AppColor.primaryColor,
                    borderColor: 0xffFF006B,
                    buttonColor: Colors.white,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    onTap: () {
                      Get.back();
                      Get.find<OrderController>()
                          .getOrderDetails(orderDetaislData.id!);
                    }),
                InkWell(
                  onTap: () {
                    Get.to(() => PaymentView(
                          orderId: orderDetaislData.id,
                        ));
                  },
                  child: Container(
                    height: 48.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      color: AppColor.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "PAY_NOW".tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ])
            : DialogButton(
                child: FittedBox(
                  child: Text(
                    "GO_TO_ORDER_DETAILS".tr,
                    style: fontMediumProWhite,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // borderColor: AppColor.primaryColor,
                color: AppColor.primaryColor,
                onPressed: () {
                  Get.back();
                  Get.find<OrderController>()
                      .getOrderDetails(orderDetaislData.id!);
                },
                radius: BorderRadius.circular(24.0.r),
              ),
      ]),
      buttons: [
        // OrderConfirmDialogButton(
        //     text: "GO_TO_ORDER_DETAILS".tr,
        //     textSize: 14.sp,
        //     textColor: AppColor.primaryColor,
        //     borderColor: 0xffFF006B,
        //     buttonColor: Colors.white,
        //     onTap: () {
        //       Get.back();
        //       Get.find<OrderController>().getOrderDetails(orderDetaislData.id!);
        //     }),

        // DialogButton(
        //   child: Text(
        //     "GO_TO_ORDER_DETAILS".tr,
        //     style: fontBoldWithColor,
        //   ),
        //   color: Colors.white,
        //   onPressed: () {
        //     Get.back();
        //     Get.find<OrderController>().getOrderDetails(orderDetaislData.id!);
        //   },
        //   radius: BorderRadius.circular(24.0.r),
        //   //  borderColor: AppColor.primaryColor,
        // ),

        // OrderConfirmDialogButton(
        //     text: "PAY_NOW".tr,
        //     textSize: 14.sp,
        //     textColor: Colors.white,
        //     //borderColor: 0xffFF006B,
        //     buttonColor: AppColor.primaryColor,
        //     onTap: () {
        //       Get.back();
        //       Get.find<OrderController>().getOrderDetails(orderDetaislData.id!);
        //     }),

        // DialogButton(
        //   child: Text(
        //     "PAY_NOW".tr,
        //     style: fontMediumProWhite,
        //   ),
        //   // borderColor: AppColor.primaryColor,
        //   color: AppColor.primaryColor,
        //   onPressed: () {
        //     Get.back();
        //     Get.find<OrderController>().getOrderDetails(orderDetaislData.id!);
        //   },
        //   radius: BorderRadius.circular(24.0.r),
        // ),
      ],
    );
  }
}

Widget cartSummarySection(context) {
  SplashController splashController = Get.put(SplashController());
  return GetBuilder<CartController>(
    builder: (cartController) => Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 100.h),
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
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24.h, left: 6.w, right: 12.w),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: cartController.cart.length,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 65.h,
                        child: Row(children: [
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                child: SizedBox(
                                  width: 70.w,
                                  height: 70.h,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          cartController.cart[index].itemImage!,
                                      imageBuilder: (context, imageProvider) =>
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
                                        child: Container(
                                            height: 130.h,
                                            width: 200.w,
                                            color: Colors.grey),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[400]!,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 22.h,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(20.r), //or 15.0
                                  child: Container(
                                    height: 20.h,
                                    width: 20.w,
                                    color: AppColor.fontColor,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        cartController.cart[index].quantity!
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          SizedBox(
                            height: 70.h,
                            width: 210.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartController.cart[index].itemName!,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                cartController.cart[index].itemVariations !=
                                        null
                                    ? SizedBox(
                                        width: 240.w,
                                        height: 20.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: cartController.cart[index]
                                              .itemVariations!.length,
                                          itemBuilder:
                                              (BuildContext context, i) {
                                            return Text(
                                              index ==
                                                      cartController
                                                              .cart[index]
                                                              .itemVariations!
                                                              .length -
                                                          1
                                                  ? "${cartController.cart[index].itemVariations![i].variationName} : ${cartController.cart[index].itemVariations![i].name}."
                                                  : "${cartController.cart[index].itemVariations![i].variationName} : ${cartController.cart[index].itemVariations![i].name}, ",
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
                                    : const SizedBox.shrink(),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Get.find<SplashController>()
                                            .configData
                                            .siteCurrencyPosition ==
                                        5
                                    ? Row(
                                        children: [
                                          Text(
                                            Get.find<SplashController>()
                                                .configData
                                                .siteDefaultCurrencySymbol!,
                                            style: fontMediumPro,
                                          ),
                                          Text(
                                            cartController
                                                .cart[index].totalPrice!
                                                .toStringAsFixed(2),
                                            style: fontMediumPro,
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            cartController
                                                .cart[index].totalPrice!
                                                .toString(),
                                            style: fontMediumPro,
                                          ),
                                          Text(
                                            Get.find<SplashController>()
                                                .configData
                                                .siteDefaultCurrencySymbol!,
                                            style: fontMediumPro,
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: cartVariationSection(index),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: cartInstructionSection(index),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            ApplyOfferCard(splashController: splashController),
            Padding(
              padding: EdgeInsets.only(
                  left: 12.w, right: 12.w, top: 16.h, bottom: 12.h),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColor.itembg)),
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
                          Row(
                            children: [
                              if (splashController
                                      .configData.siteCurrencyPosition ==
                                  5)
                                Text(
                                  splashController
                                      .configData.siteDefaultCurrencySymbol!,
                                  style: fontRegularLite,
                                ),
                              Text(
                                cartController.totalCartValue.toStringAsFixed(
                                    int.parse(splashController.configData
                                        .siteDigitAfterDecimalPoint!)),
                                style: fontRegularLite,
                              ),
                              if (splashController
                                      .configData.siteCurrencyPosition ==
                                  10)
                                Text(
                                  splashController
                                      .configData.siteDefaultCurrencySymbol!,
                                  style: fontRegularLite,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<CouponController>(
                      builder: (couponController) => Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DISCOUNT'.tr,
                              style: fontRegularLite,
                            ),
                            Row(
                              children: [
                                if (splashController
                                        .configData.siteCurrencyPosition ==
                                    5)
                                  Text(
                                    splashController
                                        .configData.siteDefaultCurrencySymbol!,
                                    style: fontRegularLite,
                                  ),
                                Text(
                                  cartController.couponDiscount.toStringAsFixed(
                                      int.parse(splashController.configData
                                          .siteDigitAfterDecimalPoint!)),
                                  style: fontRegularLite,
                                ),
                                if (splashController
                                        .configData.siteCurrencyPosition ==
                                    10)
                                  Text(
                                    splashController
                                        .configData.siteDefaultCurrencySymbol!,
                                    style: fontRegularLite,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (cartController.orderTypeIndex == 0 &&
                        cartController.orderTypeIndex != 10 &&
                        cartController.orderTypeIndex != 1 &&
                        Get.find<AddressController>()
                            .addressDataList
                            .isNotEmpty)
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DELIVERY_CHARGE'.tr,
                              style: fontRegularLite,
                            ),
                            Row(
                              children: [
                                if (splashController
                                        .configData.siteCurrencyPosition ==
                                    5)
                                  Text(
                                    splashController
                                        .configData.siteDefaultCurrencySymbol!,
                                    style: fontRegularLite,
                                  ),
                                Text(
                                  cartController.deliveryCharge.toStringAsFixed(
                                      int.parse(splashController.configData
                                          .siteDigitAfterDecimalPoint!)),
                                  style: fontRegularBoldGreen,
                                ),
                                if (splashController
                                        .configData.siteCurrencyPosition ==
                                    10)
                                  Text(
                                    splashController
                                        .configData.siteDefaultCurrencySymbol!,
                                    style: fontRegularLite,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    Text(
                      '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                      style: TextStyle(color: AppColor.gray.withOpacity(0.2)),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL'.tr,
                            style: fontMediumPro,
                          ),
                          Row(
                            children: [
                              if (splashController
                                      .configData.siteCurrencyPosition ==
                                  5)
                                Text(
                                  splashController
                                      .configData.siteDefaultCurrencySymbol!,
                                  style: fontMediumPro,
                                ),
                              Text(
                                cartController.total.toStringAsFixed(int.parse(
                                    splashController.configData
                                        .siteDigitAfterDecimalPoint!)),
                                style: fontMediumPro,
                              ),
                              if (splashController
                                      .configData.siteCurrencyPosition ==
                                  10)
                                Text(
                                  splashController
                                      .configData.siteDefaultCurrencySymbol!,
                                  style: fontMediumPro,
                                ),
                            ],
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
  );
}
