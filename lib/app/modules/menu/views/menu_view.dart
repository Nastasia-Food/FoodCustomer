// ignore_for_file: must_be_immutable, sort_child_properties_last, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/bottom_cart_widget.dart';
import '../../../../widget/item_card_grid.dart';
import '../../../../widget/item_card_list.dart';
import '../../../../widget/no_items_available.dart';
import '../../home/widget/home_vew_shimmer.dart';
import '../../search/views/search_view.dart';
import '../controllers/menu_controller.dart';
import '../widget/menu_view_shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MenuView extends StatefulWidget {
  bool? fromHome;
  int? categoryId;

  MenuView({
    Key? key,
    this.fromHome,
    this.categoryId,
  }) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final box = GetStorage();
  int? value;
  bool? isSelected;
  MenuuController menuController = Get.put(MenuuController());

  @override
  void initState() {
    Get.put(MenuuController());
    if (box.read('viewValue') == null) {
      box.write('viewValue', 0);
    }
    if (menuController.categoryDataList.isNotEmpty) {
      menuController.getCategoryWiseItemDataList(
          menuController.categoryDataList[widget.categoryId!].slug!);
      menuController.fromHome = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuuController>(
      builder: (menuController) => Scaffold(
        backgroundColor: Colors.white,
        appBar: widget.fromHome!
            ? AppBar(
                leadingWidth: 150.w,

                leading: Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        Images.back,
                        height: 25.h,
                        width: 25.w,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Image.asset(
                      Images.logo,
                      width: 85.w,
                      // height: 16.h,
                    ),
                  ],
                ),
                // title: Image.asset(
                //   Images.logo,
                //   width: 85.w,
                //   height: 16.h,
                // ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, right: 16.w, left: 16.w),
                    child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          Get.to(() => const SearchView());
                        },
                        child: SvgPicture.asset(
                          Images.iconSearch,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],

                elevation: 0,
                backgroundColor: Colors.white,
              )
            : AppBar(
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
                    padding: EdgeInsets.only(top: 8.h, right: 16.w, left: 16.w),
                    child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          Get.to(() => const SearchView());
                        },
                        child: SvgPicture.asset(
                          Images.iconSearch,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
                centerTitle: false,
                elevation: 0,
                backgroundColor: Colors.white,
              ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  menuController.categoryDataList.isNotEmpty
                      ? menuSection(widget.fromHome!, widget.categoryId!)
                      : menuSectionShimmer(),
                  menuController.categoryDataList.isNotEmpty
                      ? menuVegNonVegSection(
                          context, box, widget.fromHome!, widget.categoryId!)
                      : Column(
                          children: [menuItemSectionGridShimmer()],
                        )
                ],
              ),
            ),
            widget.fromHome! ? const BottomCartWidget() : const SizedBox()
          ],
        ),
      ),
    );
  }
}

Widget menuSection(bool fromHome, int categoryId) {
  return GetBuilder<MenuuController>(
    builder: (menuController) => Column(
      children: [
        SizedBox(
          height: 12.h,
        ),
        SizedBox(
          width: double.infinity,
          height: 80.h,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: menuController.categoryDataList.length,
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    menuController.getCategoryWiseItemDataList(
                        menuController.categoryDataList[index].slug!);
                    menuController.setCategoryIndex(index);
                    menuController.fromHome = false;
                    menuController.currentIndex = index;
                    (context as Element).markNeedsBuild();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 14.w),
                    child: SizedBox(
                      width: 90.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //here
                          SizedBox(
                            height: 30.h,
                            width: 40.w,
                            child: CachedNetworkImage(
                              imageUrl: menuController
                                  .categoryDataList[index].cover!
                                  .toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Shimmer.fromColors(
                                child: Container(
                                    height: 60.h,
                                    width: 60.w,
                                    color: Colors.grey),
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  menuController.fromHome
                                      ? Text(
                                          menuController
                                              .categoryDataList[index].name
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11.sp,
                                            color: categoryId == index
                                                ? AppColor.primaryColor
                                                : Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        )
                                      : Text(
                                          menuController
                                              .categoryDataList[index].name
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11.sp,
                                            color:
                                                menuController.currentIndex ==
                                                        index
                                                    ? AppColor.primaryColor
                                                    : Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                  menuController.fromHome
                                      ? Container(
                                          height: 4.h,
                                          width: 80.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32.r),
                                            color: categoryId == index
                                                ? AppColor.primaryColor
                                                : Colors.white,
                                          ),
                                        )
                                      : Container(
                                          height: 4.h,
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32.r),
                                            color: menuController
                                                        .selectedCategoryIndex ==
                                                    index
                                                ? AppColor.primaryColor
                                                : Colors.white,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        Container(
          height: 2.h,
          color: AppColor.bgColor,
        )
      ],
    ),
  );
}

Widget menuVegNonVegSection(context, box, bool fromHome, int categoryId) {
  return GetBuilder<MenuuController>(
    builder: (menuController) => Expanded(
      child: RefreshIndicator(
        color: AppColor.primaryColor,
        onRefresh: () async {
          menuController.getCategoryWiseItemDataList(menuController
              .categoryDataList[menuController.currentIndex].slug!);
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            menuController.getItemVgDataList(
                                10,
                                menuController
                                    .categoryDataList[
                                        menuController.currentIndex]
                                    .slug!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21.r),
                              color: menuController.vegNonVegActiveList == 10
                                  ? Colors.white
                                  : AppColor.itembg,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.itembg,
                                  offset: const Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 10.r,
                                  spreadRadius: 2.r,
                                ), //BoxShadow
                                //BoxShadow
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      Images.nonVeg,
                                      height: 20.h,
                                      width: 30.w,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      "NON_VEG".tr,
                                      style: fontRegularBold,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    menuController.vegNonVegActiveList == 10
                                        ? SvgPicture.asset(
                                            Images.IconClose,
                                            width: 20.w,
                                            height: 20.h,
                                            fit: BoxFit.contain,
                                          )
                                        : const SizedBox(),
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            menuController.getItemVgDataList(
                                5,
                                menuController
                                    .categoryDataList[
                                        menuController.currentIndex]
                                    .slug!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21.r),
                              color: menuController.vegNonVegActiveList == 5
                                  ? Colors.white
                                  : AppColor.itembg,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.itembg,
                                  offset: const Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 10.r,
                                  spreadRadius: 2.r,
                                ), //BoxShadow
                                //BoxShadow
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Images.veg,
                                      height: 20.h,
                                      width: 30.w,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      "VEG".tr,
                                      style: fontRegularBold,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    menuController.vegNonVegActiveList == 5
                                        ? SvgPicture.asset(
                                            Images.IconClose,
                                            width: 20.w,
                                            height: 20.h,
                                            fit: BoxFit.contain,
                                          )
                                        : const SizedBox(),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 34.h,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              menuController.fromHome
                                  ? menuController
                                      .categoryDataList[categoryId].name!
                                  : menuController
                                      .categoryDataList[
                                          menuController.selectedCategoryIndex]
                                      .name!,
                              style: fontBoldWithColor,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                              height: 24.h,
                              width: 66.w,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      box.write('viewValue', 0);
                                      (context as Element).markNeedsBuild();
                                    },
                                    child: SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: SvgPicture.asset(
                                        Images.iconListView,
                                        fit: BoxFit.cover,
                                        color: box.read('viewValue') == 0
                                            ? AppColor.primaryColor
                                            : AppColor.fontColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 18.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      box.write('viewValue', 1);
                                      (context as Element).markNeedsBuild();
                                    },
                                    child: SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: SvgPicture.asset(
                                        Images.iconGridView,
                                        fit: BoxFit.cover,
                                        color: box.read('viewValue') == 1
                                            ? AppColor.primaryColor
                                            : AppColor.fontColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ]),
                  ),
                  !menuController.iSmenuItemEmpty
                      ? Column(
                          children: [
                            if (box.read('viewValue') == 1)
                              menuItemSectionGrid(),
                            if (box.read('viewValue') == 0)
                              menuItemSectionList(),
                          ],
                        )
                      : const NoItemsAvailable()
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItemSectionGrid() {
  return GetBuilder<MenuuController>(
    builder: (menuController) => !menuController.menuItemLoader
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 16.w),
            child: Column(
              children: [
                StaggeredGridView.countBuilder(
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  itemCount: menuController.categoryItemDataList.length,
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                  itemBuilder: (BuildContext context, int index) {
                    return itemCardGrid(
                        menuController.categoryItemDataList, index, context);
                  },
                ),
                SizedBox(
                  height: 40.h,
                )
              ],
            ),
          )
        : menuItemSectionGridShimmer(),
  );
}

Widget menuItemSectionList() {
  return GetBuilder<MenuuController>(
    builder: (menuController) => !menuController.menuItemLoader
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              children: [
                ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: menuController.categoryItemDataList.length,
                    itemBuilder: (BuildContext context, index) {
                      return itemCardList(
                          menuController.categoryItemDataList, index, context);
                    }),
                SizedBox(
                  height: 40.h,
                )
              ],
            ),
          )
        : menuItemSectionListShimmer(),
  );
}
