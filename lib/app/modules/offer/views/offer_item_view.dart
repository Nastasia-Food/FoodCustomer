// ignore_for_file: must_be_immutable, sort_child_properties_last, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/bottom_cart_widget.dart';
import '../../../../widget/item_card_grid.dart';
import '../../../../widget/item_card_list.dart';
import '../../../../widget/no_items_available.dart';
import '../../../data/model/response/item_model.dart';
import '../controllers/offer_controller.dart';
import '../widget/offer_shimmer.dart';

class OfferItemView extends StatefulWidget {
  const OfferItemView({
    Key? key,
  }) : super(key: key);

  @override
  State<OfferItemView> createState() => _OfferItemViewState();
}

class _OfferItemViewState extends State<OfferItemView> {
  final box = GetStorage();

  int? value;
  @override
  void initState() {
    if (box.read('viewValue') == null) {
      box.write('viewValue', 0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OfferController offerController = Get.put(OfferController());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: -5,
          title: Text(
            "OFFERS".tr,
            style: fontBoldWithColor,
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
        body: offerController.lodear
            ? const OfferShimmer()
            : Stack(
                children: [
                  Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Container(
                                  height: 84.h,
                                  width: 328.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: CachedNetworkImage(
                                      imageUrl: offerController
                                          .offerItemModel.data!.image!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            // colorFilter: ColorFilter.mode(
                                            //     Colors.red,
                                            //     BlendMode.colorBurn),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
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
                                ),
                              ),
                              SizedBox(
                                height: 34.h,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        offerController
                                            .offerItemModel.data!.name!,
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
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                                child: SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: SvgPicture.asset(
                                                    Images.iconListView,
                                                    fit: BoxFit.cover,
                                                    color: box.read(
                                                                'viewValue') ==
                                                            0
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
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                                child: SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: SvgPicture.asset(
                                                    Images.iconGridView,
                                                    fit: BoxFit.cover,
                                                    color: box.read(
                                                                'viewValue') ==
                                                            1
                                                        ? AppColor.primaryColor
                                                        : AppColor.fontColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                    ]),
                              ),
                              offerController.offeritemList.isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 17.h),
                                      child: Column(
                                        children: [
                                          if (box.read('viewValue') == 1)
                                            offerItemSectionGrid(context,
                                                offerController.offeritemList),
                                          if (box.read('viewValue') == 0)
                                            offerItemSectionList(
                                                offerController.offeritemList),
                                        ],
                                      ),
                                    )
                                  : const NoItemsAvailable(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const BottomCartWidget()
                ],
              ));
  }
}

Widget offerItemSectionGrid(context, List<ItemData> itemDetails) {
  return Column(
    children: [
      StaggeredGridView.countBuilder(
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        itemCount: itemDetails.length,
        crossAxisCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        itemBuilder: (BuildContext context, int index) {
          return itemCardGrid(itemDetails, index, context);
        },
      )
    ],
  );
}

Widget offerItemSectionList(List<ItemData> itemDetails) {
  return Column(
    children: [
      ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: itemDetails.length,
          itemBuilder: (BuildContext context, index) {
            return itemCardList(itemDetails, index, context);
          }),
    ],
  );
}
