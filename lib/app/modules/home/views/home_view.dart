// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../../offer/controllers/offer_controller.dart';
import '../../search/views/search_view.dart';
import '../controllers/home_controller.dart';
import '../widget/active_order_status.dart';
import '../widget/featured_item_section.dart';
import '../widget/home_menu_section.dart';
import '../widget/home_offer_section.dart';
import '../widget/home_vew_shimmer.dart';
import '../widget/popular_item_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final box = GetStorage();
  @override
  void initState() {
    Get.find<HomeController>().getBranchList();
    Get.find<HomeController>().getCategoryList();
    Get.find<HomeController>().getPopularItemDataList();
    Get.find<HomeController>().getFeaturedItemDataList();
    Get.find<OfferController>().getOfferList();
    if (box.read('isLogedIn') == true) {
      Get.find<HomeController>().getActiveOrderList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
        builder: (homeController) => Stack(
          children: [
            Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leadingWidth: 100.w,
                  leading: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Image.asset(
                      Images.logo,
                      width: 85.w,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        children: [
                          homeController.loader
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey[200]!,
                                  highlightColor: Colors.grey[300]!,
                                  child: Container(
                                    height: 40.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : homeController.branchDataList.length != 1
                                  ? SizedBox(
                                      height: 50.h,
                                      width: 120.w,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Text(
                                            'SELECT_BRANCH'.tr,
                                            style: fontRegular,
                                          ),
                                          iconStyleData: IconStyleData(
                                            icon: SvgPicture.asset(
                                              Images.iconBranch,
                                              fit: BoxFit.cover,
                                              color: AppColor.primaryColor,
                                              height: 25.h,
                                              width: 25.w,
                                            ),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                              decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          )),
                                          items: homeController.branchDataList
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item.name.toString(),
                                                    child: Text(
                                                      item.name.toString(),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        fontFamily: 'Rubik',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          value: homeController.selectedBranch,
                                          onChanged: (value) {
                                            homeController.selectedBranch =
                                                value.toString();
                                            homeController.setIndexOfBranch();
                                            (context as Element)
                                                .markNeedsBuild();
                                          },
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                        ],
                      ),
                    )
                  ],
                  centerTitle: false,
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
                body: GetBuilder<HomeController>(
                  builder: (homeController) => Stack(
                    children: [
                      Padding(
                        padding: homeController.activeOrderData.isEmpty ||
                                box.read('isLogedIn') == false
                            ? EdgeInsets.only(left: 16.h, right: 16.h)
                            : EdgeInsets.only(
                                left: 16.h, right: 16.h, bottom: 100.h),
                        child: Column(
                          children: [
                            SizedBox(
                              child: homeController.loader
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[300]!,
                                      child: Container(
                                        height: 52.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      child: TextField(
                                        showCursor: true,
                                        readOnly: true,
                                        onTap: () {
                                          Get.to(() => const SearchView());
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0.w, vertical: 0.h),
                                          hintText: "SEARCH".tr,
                                          hintStyle: const TextStyle(
                                              color: AppColor.gray),
                                          prefixIcon: SizedBox(
                                            child: Padding(
                                              padding: EdgeInsets.all(12.r),
                                              child: SvgPicture.asset(
                                                Images.iconSearch,
                                                fit: BoxFit.cover,
                                                color: AppColor.gray,
                                                height: 16.h,
                                                width: 16.w,
                                              ),
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: AppColor.itembg,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
                                            borderSide: BorderSide(
                                                color: AppColor.itembg,
                                                width: 1.w),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
                                            borderSide: BorderSide(
                                                width: 0.w,
                                                color: AppColor.itembg),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                color: AppColor.primaryColor,
                                onRefresh: () async {
                                  homeController.getBranchList();
                                  homeController.getCategoryList();
                                  homeController.getFeaturedItemDataList();
                                  homeController.getPopularItemDataList();
                                  if (box.read('isLogedIn') == true) {
                                    homeController.getActiveOrderList();
                                  }
                                },
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          //Menu Section
                                          homeController.menuLoader ||
                                                  homeController
                                                      .categoryDataList.isEmpty
                                              ? menuSectionShimmer()
                                              : homeMenuSection(),

                                          homeController.featuredLoader ||
                                                  homeController
                                                      .featuredItemDataList
                                                      .isEmpty
                                              ? featureditemSectionShimmer()
                                              : featureditemSection(),
                                          Get.find<OfferController>()
                                                      .offerDataList
                                                      .isEmpty ||
                                                  Get.find<OfferController>()
                                                      .lodear
                                              ? const SizedBox.shrink()
                                              : homeOfferSection(),

                                          homeController.popularLoader ||
                                                  homeController
                                                      .popularItemDataList
                                                      .isEmpty
                                              ? popularItemSectionShimmer()
                                              : popularItemSection(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (homeController.activeOrderData.isNotEmpty &&
                          box.read('isLogedIn') == true)
                        const ActiveOrderStatus()
                    ],
                  ),
                )),
            Get.find<OfferController>().offerItemlodear
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
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
