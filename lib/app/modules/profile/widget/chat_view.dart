// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../home/controllers/home_controller.dart';

class ChatView extends GetView {
  ChatView({Key? key}) : super(key: key);
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'CHAT'.tr,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            addressSection(),
            SizedBox(
              height: 26.h,
            ),
            chatConversionSection()
          ],
        ),
      ),
    );
  }
}

Widget chatConversionSection() {
  return Column(
    children: [
      Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        child: Container(
            height: 652.h,
            width: 360.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        Images.shop,
                        width: 28.w,
                        height: 28.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        height: 60.h,
                        width: 252.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4.r),
                            topLeft: Radius.circular(16.r),
                            bottomLeft: Radius.circular(16.r),
                            bottomRight: Radius.circular(16.r),
                          ),
                          color: AppColor.delivaryInactive,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4.r),
                          child: const Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed feugiat bibendum ac.',
                              maxLines: 3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  const Text('11-9-2022, 12:56'),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 60.h,
                        width: 252.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4.r),
                            topLeft: Radius.circular(16.r),
                            bottomLeft: Radius.circular(16.r),
                            bottomRight: Radius.circular(16.r),
                          ),
                          color: AppColor.viewAllbg,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4.r),
                          child: const Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed feugiat bibendum ac.',
                              maxLines: 3),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      SvgPicture.asset(
                        Images.shop,
                        width: 28.w,
                        height: 28.h,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        Images.gallery,
                        width: 28.w,
                        height: 28.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      SizedBox(
                        width: 238.w,
                        height: 50.h,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'TYPE_A_MESSAGE'.tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      SvgPicture.asset(
                        Images.send,
                        width: 28.w,
                        height: 28.h,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    ],
  );
}

// Widget addressSection(context, isActive) {
//   return Column(
//     children: [
//       SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 16),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.r),
//                   color: false ? AppColor.primaryColor : Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColor.itembg,
//                       offset: const Offset(
//                         0.0,
//                         4.0,
//                       ),
//                       blurRadius: 5.r,
//                       spreadRadius: 0.r,
//                     ),
//                     BoxShadow(
//                       color: AppColor.itembg,
//                       offset: const Offset(
//                         0.0,
//                         0.0,
//                       ),
//                       blurRadius: 1.r,
//                       spreadRadius: 0.r,
//                     ), //BoxShadow
//                     //BoxShadow
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.r),
//                   child: SizedBox(
//                     height: 32.h,
//                     child: Center(
//                         child: Text(
//                       'Boshundhora R/A',
//                       style: TextStyle(
//                         fontFamily: 'Rubik',
//                         fontSize: 12.sp,
//                         fontWeight: false ? FontWeight.w500 : FontWeight.w400,
//                         color: false ? Colors.white : Colors.black,
//                       ),
//                     )),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.r),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.r),
//                   color: isActive ? AppColor.primaryColor : Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColor.itembg,
//                       offset: const Offset(
//                         0.0,
//                         4.0,
//                       ),
//                       blurRadius: 5.r,
//                       spreadRadius: 0.r,
//                     ),
//                     BoxShadow(
//                       color: AppColor.itembg,
//                       offset: const Offset(
//                         0.0,
//                         0.0,
//                       ),
//                       blurRadius: 1.r,
//                       spreadRadius: 0.r,
//                     ), //BoxShadow
//                     //BoxShadow
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.r),
//                   child: SizedBox(
//                     height: 32.h,
//                     child: Center(
//                         child: Text(
//                       'Gulshan-2',
//                       style: TextStyle(
//                         fontFamily: 'Rubik',
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w500,
//                         color: isActive ? Colors.white : Colors.black,
//                       ),
//                     )),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.r),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.r),
//                   color: false ? AppColor.primaryColor : Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColor.itembg,
//                       offset: const Offset(
//                         0.0,
//                         4.0,
//                       ),
//                       blurRadius: 5.r,
//                       spreadRadius: 0.r,
//                     ),
//                     BoxShadow(
//                       color: AppColor.itembg,
//                       offset: const Offset(
//                         0.0,
//                         0.0,
//                       ),
//                       blurRadius: 1.r,
//                       spreadRadius: 0.r,
//                     ), //BoxShadow
//                     //BoxShadow
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.r),
//                   child: SizedBox(
//                     height: 32.h,
//                     child: Center(
//                         child: Text(
//                       'Dhanmondi',
//                       style: TextStyle(
//                         fontFamily: 'Rubik',
//                         fontSize: 12.sp,
//                         fontWeight: false ? FontWeight.w500 : FontWeight.w400,
//                         color: false ? Colors.white : Colors.black,
//                       ),
//                     )),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.r),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.r),
//                   color: false ? AppColor.primaryColor : Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColor.itembg,
//                       offset: const Offset(
//                         0.0,
//                         4.0,
//                       ),
//                       blurRadius: 5.r,
//                       spreadRadius: 0.r,
//                     ),
//                     BoxShadow(
//                       color: AppColor.itembg,
//                       offset: const Offset(
//                         0.0,
//                         0.0,
//                       ),
//                       blurRadius: 1.r,
//                       spreadRadius: 0.r,
//                     ), //BoxShadow
//                     //BoxShadow
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.r),
//                   child: SizedBox(
//                     height: 32.h,
//                     child: Center(
//                         child: Text(
//                       'Banani',
//                       style: TextStyle(
//                         fontFamily: 'Rubik',
//                         fontSize: 12.sp,
//                         fontWeight: false ? FontWeight.w500 : FontWeight.w400,
//                         color: false ? Colors.white : Colors.black,
//                       ),
//                     )),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

Widget addressSection() {
  bool isActive = true;
  return GetBuilder<HomeController>(
    builder: (homeController) => Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            children: [
              Text(
                "SELECT_BRUNCH".tr,
                style: fontMedium,
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: SizedBox(
              height: 50.h,
              child: Row(
                children: [
                  ListView.builder(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: homeController.branchDataList.length,
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {
                            homeController.selectedBranch =
                                homeController.branchDataList[index].name!;

                            (context as Element).markNeedsBuild();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: homeController.selectedBranch ==
                                        homeController
                                            .branchDataList[index].name
                                    ? AppColor.primaryColor
                                    : Colors.white,
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
                              child: Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: SizedBox(
                                  height: 32.h,
                                  child: Center(
                                      child: Text(
                                    homeController.branchDataList[index].name!,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 12.sp,
                                      fontWeight:
                                          homeController.selectedBranch ==
                                                  homeController
                                                      .branchDataList[index]
                                                      .name
                                              ? FontWeight.w500
                                              : FontWeight.w400,
                                      color: homeController.selectedBranch ==
                                              homeController
                                                  .branchDataList[index].name
                                          ? Colors.white
                                          : Colors.black,
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
          ),
        ),
      ],
    ),
  );
}
