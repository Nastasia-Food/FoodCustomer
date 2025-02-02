// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_bottom_widget.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/empty_cart_view.dart';

class CartView extends StatefulWidget {
  bool? fromNav;
  CartView({Key? key, this.fromNav}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.put(SplashController());
    return GetBuilder<CartController>(
      builder: (cartController) => (Scaffold(
        backgroundColor: Colors.white,
        appBar: widget.fromNav!
            ? AppBar(
                title: Text(
                  "MY_CART".tr,
                  style: fontBoldWithColor,
                ),
                actions: [
                  if (splashController.configData.orderSetupDelivery == 5 &&
                      splashController.configData.orderSetupTakeaway == 5)
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
                          inactiveBgColor: AppColor.delivaryInactive,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: 0,
                          customTextStyles: [fontMediumProWhite],
                          totalSwitches: 2,
                          labels: ['DELIVERY'.tr, 'TAKEAWAY'.tr],
                          radiusStyle: true,
                          onToggle: (index) {
                            cartController.orderTypeIndex = index!;
                          },
                        ),
                      ),
                    ),
                  if (splashController.configData.orderSetupDelivery == 5 &&
                      splashController.configData.orderSetupTakeaway == 10)
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
                          inactiveBgColor: AppColor.delivaryInactive,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: 0,
                          customTextStyles: [fontMediumProWhite],
                          totalSwitches: 1,
                          labels: ['DELIVERY'.tr],
                          radiusStyle: true,
                          onToggle: (index) {
                            cartController.orderTypeIndex = index!;
                          },
                        ),
                      ),
                    ),
                  if (splashController.configData.orderSetupDelivery == 10 &&
                      splashController.configData.orderSetupTakeaway == 5)
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
                          inactiveBgColor: AppColor.delivaryInactive,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: 0,
                          customTextStyles: [fontMediumProWhite],
                          totalSwitches: 1,
                          labels: ['TAKEAWAY'.tr],
                          radiusStyle: true,
                        ),
                      ),
                    ),
                ],
                centerTitle: false,
                elevation: 0,
                backgroundColor: Colors.white,
              )
            : AppBar(
                title: Text(
                  "MY_CART".tr,
                  style: fontBoldWithColor,
                ),
                leading: IconButton(
                  icon: SvgPicture.asset(Images.back),
                  onPressed: () {
                    Get.back();
                  },
                ),
                actions: [
                  if (splashController.configData.orderSetupDelivery == 5 &&
                      splashController.configData.orderSetupTakeaway == 5)
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
                          inactiveBgColor: AppColor.delivaryInactive,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: 0,
                          customTextStyles: [fontMediumProWhite],
                          totalSwitches: 2,
                          labels: ['DELIVERY'.tr, 'TAKEAWAY'.tr],
                          radiusStyle: true,
                          onToggle: (index) {
                            cartController.orderTypeIndex = index!;
                          },
                        ),
                      ),
                    ),
                  if (splashController.configData.orderSetupDelivery == 5 &&
                      splashController.configData.orderSetupTakeaway == 10)
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
                          inactiveBgColor: AppColor.delivaryInactive,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: 0,
                          customTextStyles: [fontMediumProWhite],
                          totalSwitches: 1,
                          labels: ['DELIVERY'.tr],
                          radiusStyle: true,
                          onToggle: (index) {
                            cartController.orderTypeIndex = index!;
                          },
                        ),
                      ),
                    ),
                  if (splashController.configData.orderSetupDelivery == 10 &&
                      splashController.configData.orderSetupTakeaway == 5)
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
                          inactiveBgColor: AppColor.delivaryInactive,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: 0,
                          customTextStyles: [fontMediumProWhite],
                          totalSwitches: 1,
                          labels: ['TAKEAWAY'.tr],
                          radiusStyle: true,
                        ),
                      ),
                    ),
                ],
                centerTitle: false,
                elevation: 0,
                backgroundColor: Colors.white,
              ),
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            cartController.cart.isNotEmpty
                ? Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 160),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            primary: false,
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                cartItemSection(),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: widget.fromNav! ? 40 : 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.itembg.withOpacity(0.5),
                                  offset: const Offset(
                                    0.0,
                                    -10.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 3.0,
                                ), //BoxShadow
                                //BoxShadow
                              ],
                            ),
                            child: cartBottomSection(),
                          ),
                        ),
                      ],
                    ),
                  )
                : const EmptyCartView(),
          ],
        ),
      )),
    );
  }
}
