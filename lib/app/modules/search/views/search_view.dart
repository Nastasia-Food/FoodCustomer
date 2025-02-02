// ignore_for_file: unnecessary_string_interpolations, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/bottom_cart_widget.dart';
import '../../../../widget/item_card_grid.dart';
import '../../../../widget/item_card_list.dart';
import '../../../../widget/no_items_available.dart';
import '../../home/controllers/home_controller.dart';
import '../../menu/widget/menu_view_shimmer.dart';
import '../controllers/search_controller.dart' as search;

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final box = GetStorage();

  String itemName = '';
  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    if (box.read('viewValue') == null) {
      box.write('viewValue', 0);
    }
    Get.find<search.SearchController>().filterItem('');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<search.SearchController>(
      builder: (searchController) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            titleSpacing: -5,
            title: InkWell(
              onTap: () {
                searchController.getData();
              },
              child: Text(
                'Search',
                style: fontBoldWithColorBlack,
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
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 52.h,
                      child: TextField(
                        showCursor: true,
                        readOnly: false,
                        onChanged: (value) =>
                            searchController.filterItem(value),
                        controller: searchTextController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 0.w, vertical: 0.h),
                          hintText: "SEARCH".tr,
                          hintStyle: const TextStyle(color: AppColor.gray),
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
                          suffixIcon: SizedBox(
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: InkWell(
                                onTap: () {
                                  searchTextController.clear();
                                  searchController
                                      .filterItem(searchTextController.text);
                                },
                                child: Image.asset(
                                  Images.closeCircle,
                                  fit: BoxFit.cover,
                                  color: AppColor.primaryColor,
                                  height: 16.h,
                                  width: 16.w,
                                ),
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: AppColor.itembg,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            borderSide:
                                BorderSide(color: AppColor.itembg, width: 1.w),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            borderSide:
                                BorderSide(width: 0.w, color: AppColor.itembg),
                          ),
                        ),
                      ),
                    ),
                    menuContent(context, box),
                  ],
                ),
              ),
              const BottomCartWidget()
            ],
          )),
    );
  }
}

Widget menuContent(context, box) {
  return GetBuilder<search.SearchController>(
    builder: (searchController) => Expanded(
      child: RefreshIndicator(
        color: AppColor.primaryColor,
        onRefresh: () async {
          Get.find<search.SearchController>().filterItem('');
          searchController.getData();
          Get.find<HomeController>().getItemDataList();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 34.h,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${searchController.foundItem.length.toString()}" +
                            ' ' +
                            "ITEMS_AVAILABLE".tr,
                        style: fontBoldWithColor,
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
              searchController.foundItem.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 17.h),
                      child: Column(
                        children: [
                          //Menu Section
                          if (box.read('viewValue') == 1) menuItemSectionGrid(),
                          if (box.read('viewValue') == 0) menuItemSectionList(),
                        ],
                      ),
                    )
                  : const NoItemsAvailable(),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget menuItemSectionGrid() {
  return GetBuilder<search.SearchController>(
      builder: (searchController) => !searchController.itemLoader
          ? Column(
              children: [
                StaggeredGridView.countBuilder(
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  itemCount: searchController.foundItem.length,
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                  itemBuilder: (BuildContext context, int index) {
                    return itemCardGrid(
                        searchController.foundItem, index, context);
                  },
                ),
                SizedBox(
                  height: 55.h,
                )
              ],
            )
          : menuItemSectionGridShimmer());
}

Widget menuItemSectionList() {
  return GetBuilder<search.SearchController>(
    builder: (searchController) => !searchController.itemLoader
        ? Column(
            children: [
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: searchController.foundItem.length,
                  itemBuilder: (BuildContext context, index) {
                    return itemCardList(
                        searchController.foundItem, index, context);
                  }),
              SizedBox(
                height: 55.h,
              )
            ],
          )
        : menuItemSectionListShimmer(),
  );
}
