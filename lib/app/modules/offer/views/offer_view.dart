// ignore_for_file: sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../../../../widget/no_items_available.dart';
import '../controllers/offer_controller.dart';
import '../widget/offer_shimmer.dart';

class OfferView extends StatefulWidget {
  const OfferView({super.key});

  @override
  State<OfferView> createState() => _OfferViewState();
}

class _OfferViewState extends State<OfferView> {
  @override
  void initState() {
    Get.put(OfferController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferController>(
      builder: (offerController) => SafeArea(
          child: Stack(
        children: [
          Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "OFFERS".tr,
                  style: fontBoldWithColorBlack,
                ),
                centerTitle: false,
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              body: GetBuilder<OfferController>(
                builder: (offerController) => offerController.lodear
                    ? const OfferShimmer()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                        child: Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                color: AppColor.primaryColor,
                                onRefresh: () async {
                                  offerController.getOfferList();
                                },
                                child: SingleChildScrollView(
                                  child: offerController
                                          .offerDataList.isNotEmpty
                                      ? ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: offerController
                                              .offerDataList.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return InkWell(
                                              onTap: () {
                                                offerController
                                                    .getOfferItemList(
                                                        offerController
                                                            .offerDataList[
                                                                index]
                                                            .slug
                                                            .toString());
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 12.h),
                                                child: Container(
                                                  height: 84.h,
                                                  width: 328.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                    child: CachedNetworkImage(
                                                      imageUrl: offerController
                                                          .offerDataList[index]
                                                          .image
                                                          .toString(),
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                            // colorFilter: ColorFilter.mode(
                                                            //     Colors.red,
                                                            //     BlendMode.colorBurn),
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Shimmer.fromColors(
                                                        child: Container(
                                                            height: 60.h,
                                                            width: 60.w,
                                                            color: Colors.grey),
                                                        baseColor:
                                                            Colors.grey[300]!,
                                                        highlightColor:
                                                            Colors.grey[400]!,
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                      : const NoItemsAvailable(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              )),
          offerController.offerItemlodear
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
      )),
    );
  }
}
