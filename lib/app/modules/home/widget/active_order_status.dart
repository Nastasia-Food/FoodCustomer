// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../controllers/home_controller.dart';
import '../../order/controllers/order_controller.dart';

class ActiveOrderStatus extends StatefulWidget {
  const ActiveOrderStatus({super.key});

  @override
  State<ActiveOrderStatus> createState() => _ActiveOrderStatusState();
}

class _ActiveOrderStatusState extends State<ActiveOrderStatus> {
  @override
  void initState() {
    Get.put(OrderController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) =>
          // homeController.activeOrderLoader
          //     ? Positioned(
          //         bottom: 0,
          //         child: Shimmer.fromColors(
          //           baseColor: Colors.white,
          //           highlightColor: Colors.grey[200]!,
          //           child: Container(
          //             width: Get.width,
          //             height: 100.h,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(16.r),
          //                 topRight: Radius.circular(16.r),
          //               ),
          //             ),
          //             child: Container(
          //               width: Get.width,
          //               height: 100.h,
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.only(
          //                   topLeft: Radius.circular(16.r),
          //                   topRight: Radius.circular(16.r),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          // :
          Positioned(
        bottom: 0,
        child: InkWell(
          onTap: () {
            Get.find<OrderController>()
                .getOrderDetails(homeController.activeOrderData[0].id!);
          },
          child: Container(
            width: Get.width,
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              color: AppColor.viewAllbg,
            ),
            child: Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: SvgPicture.asset(
                              Images.iconRouting,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 8.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (homeController.activeOrderData[0].status == 1)
                                Text(
                                  "YOOUR_ORDER_IS_PLACED_SUCCESSFULLY".tr,
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: AppColor.primaryColor),
                                ),
                              if (homeController.activeOrderData[0].status == 4)
                                Text(
                                  "YOUR_ORDER_HAS_BEEN_ACCEPTED".tr,
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: AppColor.primaryColor),
                                ),
                              if (homeController.activeOrderData[0].status == 7)
                                Text(
                                  "RESTAURANT_IS_PREPARING_YOUR_FOOD".tr,
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: AppColor.primaryColor),
                                ),
                              if (homeController.activeOrderData[0].status ==
                                  10)
                                Text(
                                  "YOUR_FOOD_IS_ON_THE_WAY".tr,
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: AppColor.primaryColor),
                                ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "IT_WILL_TAKE_LESS_THAN".tr + ' ',
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: AppColor.primaryColor),
                                  ),
                                  Text(
                                    homeController
                                        .activeOrderData[0].preparationTime
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: AppColor.primaryColor),
                                  ),
                                  Text(
                                    ' ' + "MINUTES_TO_GET_YOUR_FOOD".tr,
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: AppColor.primaryColor),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: SvgPicture.asset(
                          Images.round_arrow,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                    width: 302.w,
                    height: 16.h,
                    child: SvgPicture.asset(
                      Images.iconTimeline,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
