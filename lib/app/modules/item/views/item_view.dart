// ignore_for_file: avoid_function_literals_in_foreach_calls, must_be_immutable, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, sort_child_properties_last, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/custom_toast.dart';
import '../../../data/model/body/place_order_body.dart';
import '../../../data/model/response/item_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../splash/controllers/splash_controller.dart';

class ItemView extends StatefulWidget {
  ItemData? itemDetails;
  int? indexNumber;
  ItemView({Key? key, this.itemDetails, this.indexNumber}) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  bool isActive = true;
  final TextEditingController instructionTextController =
      TextEditingController();
  List<Variations> variationList = [];
  List<Extras> extraList = [];
  List<Addons> addonList = [];

  final box = GetStorage();

  double totalPrice = 0.0;
  double cartTotal = 0.0;
  double itemPrice = 0;
  double variationTotal = 0.0;
  double variationSum = 0.0;
  double extraTotal = 0.0;
  double extraSum = 0.0;
  int itemQuantity = 0;
  int addOnsQuantity = 1;
  int qty = 1;

  @override
  void initState() {
    super.initState();
    Get.find<CartController>().itemQuantity = 1;
    Get.find<CartController>().selectedExtraIndex.clear();
    Get.find<CartController>().selectedAddOnsIndex.clear();

    if (widget.itemDetails!.itemAttributes!.isNotEmpty) {
      widget.itemDetails!.itemAttributes!.forEach((e) {
        variationList.add(
          (Variations(
            id: widget.itemDetails!.variations[e.id.toString()][0]['id'],
            itemAttributeId: int.parse(widget.itemDetails!
                .variations[e.id.toString()][0]['item_attribute_id']
                .toString()),
            name: widget.itemDetails!.variations[e.id.toString()][0]['name'],
            variationName: widget.itemDetails!.itemAttributes![0].name,
            price: double.parse(widget
                .itemDetails!.variations[e.id.toString()][0]['convert_price']
                .toString()),
          )),
        );
      });
    }

    setState(() {
      totalPrice = widget.itemDetails!.offer!.isNotEmpty
          ? widget.itemDetails!.offer![0].convertPrice! *
              Get.find<CartController>().itemQuantity
          : widget.itemDetails!.convertPrice! *
              Get.find<CartController>().itemQuantity;
      if (extraList.isNotEmpty) {
        extraList.forEach((e) {
          extraSum += e.price!;
          extraTotal = extraSum * Get.find<CartController>().itemQuantity;
        });
      }
      if (variationList.isNotEmpty) {
        variationList.forEach((v) {
          variationSum += v.price!;
          variationTotal =
              variationSum * Get.find<CartController>().itemQuantity;
        });
      }
      if (addonList.isNotEmpty) {
        addonList.forEach((a) {
          totalPrice += a.totalConvertPrice! * a.quantity!;
          itemQuantity += a.quantity!;
        });
      }
      cartTotal = totalPrice + extraTotal + variationTotal;
    });
  }

  addItemAddons(
      id, itemId, name, price, qty, image, variationTotal, totalConvertPrice) {
    addonList.add(
      Addons(
          id: id,
          itemId: itemId,
          name: name,
          price: double.parse(price),
          image: image,
          quantity: qty,
          itemVariationTotal: double.parse(variationTotal),
          itemExtraTotal: 0.0,
          totalConvertPrice: totalConvertPrice),
    );
  }

  removeItemAddons(id, itemId, name, price, qty, image, index, variationTotal,
      totalConvertPrice) {
    addonList[index] = (Addons(
        id: id,
        itemId: itemId,
        name: name,
        price: double.parse(price),
        image: image,
        quantity: qty,
        itemVariationTotal: double.parse(variationTotal),
        itemExtraTotal: 0.0,
        totalConvertPrice: totalConvertPrice));
  }

  plusItemAddons(id, itemId, name, price, qty, image, index, variationTotal,
      totalConvertPrice) {
    addonList[index] = (Addons(
        id: id,
        itemId: itemId,
        name: name,
        price: double.parse(price),
        image: image,
        quantity: qty,
        itemVariationTotal: double.parse(variationTotal),
        itemExtraTotal: 0.0,
        totalConvertPrice: totalConvertPrice));
  }

  removeAddonFromCart(id) {
    addonList.removeWhere((item) => item.id == id);
  }

  @override
  Widget build(BuildContext context) {
    calculate() {
      variationTotal = 0.0;
      extraTotal = 0.0;
      cartTotal = 0.0;
      variationSum = 0.0;
      extraSum = 0.0;
      setState(() {
        totalPrice = widget.itemDetails!.offer!.isNotEmpty
            ? widget.itemDetails!.offer![0].convertPrice! *
                Get.find<CartController>().itemQuantity
            : widget.itemDetails!.convertPrice! *
                Get.find<CartController>().itemQuantity;
        if (extraList.isNotEmpty) {
          extraList.forEach((e) {
            extraSum += e.price!;
            extraTotal = extraSum * Get.find<CartController>().itemQuantity;
            // totalPrice += e.price!;
          });
        }
        if (variationList.isNotEmpty) {
          variationList.forEach((v) {
            variationSum += v.price!;
            variationTotal =
                variationSum * Get.find<CartController>().itemQuantity;
            // totalPrice += v.price!;
          });
        }
        if (addonList.isNotEmpty) {
          addonList.forEach((a) {
            totalPrice += a.totalConvertPrice! * a.quantity!;
            itemQuantity += a.quantity!;
          });
        }
        cartTotal = totalPrice + extraTotal + variationTotal;
      });
    }

    return GetBuilder<CartController>(
      builder: (cartController) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.gray.withOpacity(0.5),
              offset: const Offset(
                0.0,
                6.0,
              ),
              blurRadius: 30.r,
              spreadRadius: 10.r,
            ),
            //BoxShadow
            //BoxShadow
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 16.h, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              bottomSheetItem(widget.itemDetails!, widget.indexNumber, context),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "QUANTITY".tr + " : ",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    Container(
                      height: 30.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColor.searchBarbg,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              cartController.removeQuantity();
                              calculate();
                            },
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: cartController.itemQuantity > 0
                                  ? Image.asset(
                                      Images.IconRemoveItem,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      Images.IconRemoveItem,
                                      fit: BoxFit.cover,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                          Text(
                            cartController.itemQuantity.toString(),
                            style: fontSemiBold,
                          ),
                          InkWell(
                            onTap: () {
                              cartController.addQuantity();
                              calculate();
                            },
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: SvgPicture.asset(
                                Images.IconAddItem,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (widget.itemDetails!.itemAttributes!.isNotEmpty)
                      MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            //itemCount: itemdetails.itemAttributes!.length,
                            itemCount:
                                widget.itemDetails!.itemAttributes!.length,
                            itemBuilder: (BuildContext context, y) {
                              // variation section
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: 16.h, left: 16.h, right: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.itemDetails!.itemAttributes![y]
                                          .name!,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    SizedBox(
                                      height: 52.h,
                                      child: SingleChildScrollView(
                                        primary: false,
                                        scrollDirection: Axis.horizontal,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: widget
                                                .itemDetails!
                                                .variations![widget.itemDetails!
                                                    .itemAttributes![y].id
                                                    .toString()]!
                                                .length,
                                            itemBuilder:
                                                (BuildContext context, x) {
                                              return InkWell(
                                                onTap: () {
                                                  if ((variationList.every((item) =>
                                                      item.id !=
                                                      widget.itemDetails!
                                                                  .variations[
                                                              widget
                                                                  .itemDetails!
                                                                  .itemAttributes![
                                                                      y]
                                                                  .id
                                                                  .toString()]
                                                          [x]['id']))) {
                                                    variationList[y] =
                                                        ((Variations(
                                                      id: widget.itemDetails!
                                                                  .variations[
                                                              widget
                                                                  .itemDetails!
                                                                  .itemAttributes![
                                                                      y]
                                                                  .id
                                                                  .toString()]
                                                          [x]['id'],
                                                      itemId: int.parse(widget
                                                          .itemDetails!
                                                          .variations[widget
                                                                  .itemDetails!
                                                                  .itemAttributes![
                                                                      y]
                                                                  .id
                                                                  .toString()]
                                                              [x]['item_id']
                                                          .toString()),
                                                      itemAttributeId: int.parse(widget
                                                          .itemDetails!
                                                          .variations[widget
                                                                  .itemDetails!
                                                                  .itemAttributes![
                                                                      y]
                                                                  .id
                                                                  .toString()]
                                                              [x][
                                                              'item_attribute_id']
                                                          .toString()),
                                                      name: widget.itemDetails!
                                                                  .variations[
                                                              widget
                                                                  .itemDetails!
                                                                  .itemAttributes![
                                                                      y]
                                                                  .id
                                                                  .toString()]
                                                          [x]['name'],
                                                      variationName: widget
                                                          .itemDetails!
                                                          .itemAttributes![y]
                                                          .name,
                                                      price: double.parse(widget
                                                          .itemDetails!
                                                          .variations[widget
                                                                  .itemDetails!
                                                                  .itemAttributes![
                                                                      y]
                                                                  .id
                                                                  .toString()]
                                                              [x]
                                                              ['convert_price']
                                                          .toString()),
                                                    )));
                                                  }
                                                  calculate();
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                                // ,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 12),
                                                      alignment:
                                                          Alignment.center,
                                                      height: 52.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        color: variationList[y]
                                                                    .id ==
                                                                widget.itemDetails!.variations[widget
                                                                        .itemDetails!
                                                                        .itemAttributes![
                                                                            y]
                                                                        .id
                                                                        .toString()]
                                                                    [x]['id']
                                                            ? AppColor
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.08)
                                                            : AppColor.itembg,
                                                        border: variationList[y]
                                                                    .id ==
                                                                widget.itemDetails!.variations[widget
                                                                        .itemDetails!
                                                                        .itemAttributes![
                                                                            y]
                                                                        .id
                                                                        .toString()]
                                                                    [x]['id']
                                                            ? Border.all(
                                                                color: AppColor
                                                                    .primaryColor)
                                                            : Border.all(
                                                                color: Colors.white),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8.w),
                                                            child: SizedBox(
                                                              height: 52.h,
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 20.w,
                                                                    height:
                                                                        20.h,
                                                                    child: variationList[y].id ==
                                                                            widget.itemDetails!.variations[widget.itemDetails!.itemAttributes![y].id.toString()][x][
                                                                                'id']
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
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 6.w,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                left: box.read(
                                                                            'languageCode') ==
                                                                        'ar'
                                                                    ? 10.w
                                                                    : 0.w),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  widget
                                                                      .itemDetails!
                                                                      .variations![widget
                                                                          .itemDetails!
                                                                          .itemAttributes![
                                                                              y]
                                                                          .id
                                                                          .toString()]![x]['name']
                                                                      .toString(),
                                                                  style:
                                                                      fontRegular,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                ),
                                                                SizedBox(
                                                                  height: 4.h,
                                                                ),
                                                                Text(
                                                                  widget
                                                                      .itemDetails!
                                                                      .variations![widget
                                                                          .itemDetails!
                                                                          .itemAttributes![
                                                                              y]
                                                                          .id
                                                                          .toString()]![x]['currency_price']
                                                                      .toString(),
                                                                  style:
                                                                      fontRegularBold,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    //extra section
                    if (widget.itemDetails!.extras!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16.w, right: 8.w, bottom: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EXTRAS".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            SizedBox(
                              height: 52.h,
                              child: SingleChildScrollView(
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        widget.itemDetails!.extras!.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (cartController.selectedExtraIndex
                                              .contains(index)) {
                                            cartController.selectedExtraIndex
                                                .remove(index);

                                            extraList.removeWhere((item) =>
                                                item.id ==
                                                widget.itemDetails!
                                                    .extras![index].id);
                                          } else {
                                            cartController.selectedExtraIndex
                                                .add(index);

                                            if (extraList.every((item) =>
                                                item.id !=
                                                widget.itemDetails!
                                                    .extras![index].id)) {
                                              extraList.add(Extras(
                                                  id: widget.itemDetails!
                                                      .extras![index].id,
                                                  itemId: widget.itemDetails!
                                                      .extras![index].itemId!,
                                                  name: widget.itemDetails!
                                                      .extras![index].name,
                                                  price: double.parse(widget
                                                      .itemDetails!
                                                      .extras![index]
                                                      .price!)));
                                            }
                                          }
                                          calculate();
                                          (context as Element).markNeedsBuild();
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 0.w, right: 12.w),
                                              alignment: Alignment.center,
                                              height: 52.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: cartController
                                                        .selectedExtraIndex
                                                        .contains(index)
                                                    ? AppColor.primaryColor
                                                        .withOpacity(0.08)
                                                    : AppColor.searchBarbg,
                                                border: cartController
                                                        .selectedExtraIndex
                                                        .contains(index)
                                                    ? Border.all(
                                                        color: AppColor
                                                            .primaryColor)
                                                    : Border.all(
                                                        color: Colors.white),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.w),
                                                    child: SizedBox(
                                                      height: 52.h,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 16.w,
                                                            height: 16.h,
                                                            child: cartController
                                                                    .selectedExtraIndex
                                                                    .contains(
                                                                        index)
                                                                ? SvgPicture
                                                                    .asset(
                                                                    Images
                                                                        .iconTickedYes,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : SvgPicture
                                                                    .asset(
                                                                    Images
                                                                        .iconTickedNo,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        child: Text(
                                                          widget
                                                              .itemDetails!
                                                              .extras![index]
                                                              .name!
                                                              .toString(),
                                                          style: fontRegular,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4.h,
                                                      ),
                                                      Text(
                                                        widget
                                                            .itemDetails!
                                                            .extras![index]
                                                            .currencyPrice
                                                            .toString(),
                                                        style: fontRegularBold,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),

                    //Addons section,
                    if (widget.itemDetails!.addons!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.h, bottom: 24.h, left: 16.w, right: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ADDONS".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 70.h,
                              child: SingleChildScrollView(
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        widget.itemDetails!.addons!.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 9.w),
                                        child: Container(
                                          height: 80.h,
                                          width: 250.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            color: cartController
                                                    .selectedAddOnsIndex
                                                    .contains(index)
                                                ? AppColor.primaryColor
                                                    .withOpacity(0.08)
                                                : Colors.white,
                                            border: cartController
                                                    .selectedAddOnsIndex
                                                    .contains(index)
                                                ? Border.all(
                                                    color:
                                                        AppColor.primaryColor)
                                                : Border.all(
                                                    color: AppColor.itembg),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (cartController
                                                      .selectedAddOnsIndex
                                                      .contains(index)) {
                                                    cartController
                                                        .selectedAddOnsIndex
                                                        .remove(index);

                                                    removeAddonFromCart(widget
                                                        .itemDetails!
                                                        .addons![index]
                                                        .itemAddonId);
                                                    (context as Element)
                                                        .markNeedsBuild();
                                                  } else {
                                                    cartController
                                                        .selectedAddOnsIndex
                                                        .add(index);
                                                    if (addonList.every(
                                                        (item) =>
                                                            item.id !=
                                                            widget
                                                                .itemDetails!
                                                                .addons![index]
                                                                .itemAddonId)) {
                                                      addItemAddons(
                                                          widget
                                                              .itemDetails!
                                                              .addons![index]
                                                              .itemAddonId,
                                                          widget
                                                              .itemDetails!
                                                              .addons![index]
                                                              .itemId,
                                                          widget
                                                              .itemDetails!
                                                              .addons![index]
                                                              .addonItemName,
                                                          widget
                                                              .itemDetails!
                                                              .addons![index]
                                                              .addonItemConvertPrice
                                                              .toString(),
                                                          addOnsQuantity,
                                                          widget
                                                              .itemDetails!
                                                              .addons![index]
                                                              .cover,
                                                          widget
                                                              .itemDetails!
                                                              .addons![index]
                                                              .variationTotalConvertPrice
                                                              .toString(),
                                                          widget
                                                              .itemDetails!
                                                              .addons![index]
                                                              .totalConvertPrice);
                                                      (context as Element)
                                                          .markNeedsBuild();
                                                    }
                                                  }

                                                  calculate();
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                                child: SizedBox(
                                                  height: 70.h,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 70.w,
                                                        height: 70.h,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                8.r),
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: widget
                                                                .itemDetails!
                                                                .addons![index]
                                                                .cover!,
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
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.w,
                                                    top: 0.h,
                                                    right: 8.w),
                                                child: SizedBox(
                                                  height: 70.h,
                                                  width: 160.w,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              if (cartController
                                                                  .selectedAddOnsIndex
                                                                  .contains(
                                                                      index)) {
                                                                cartController
                                                                    .selectedAddOnsIndex
                                                                    .remove(
                                                                        index);

                                                                removeAddonFromCart(widget
                                                                    .itemDetails!
                                                                    .addons![
                                                                        index]
                                                                    .itemAddonId);
                                                                (context
                                                                        as Element)
                                                                    .markNeedsBuild();
                                                              } else {
                                                                cartController
                                                                    .selectedAddOnsIndex
                                                                    .add(index);
                                                                if (addonList.every((item) =>
                                                                    item.id !=
                                                                    widget
                                                                        .itemDetails!
                                                                        .addons![
                                                                            index]
                                                                        .itemAddonId)) {
                                                                  addItemAddons(
                                                                      widget
                                                                          .itemDetails!
                                                                          .addons![
                                                                              index]
                                                                          .itemAddonId,
                                                                      widget
                                                                          .itemDetails!
                                                                          .addons![
                                                                              index]
                                                                          .itemAddonId,
                                                                      widget
                                                                          .itemDetails!
                                                                          .addons![
                                                                              index]
                                                                          .addonItemName,
                                                                      widget
                                                                          .itemDetails!
                                                                          .addons![
                                                                              index]
                                                                          .addonItemConvertPrice
                                                                          .toString(),
                                                                      addOnsQuantity,
                                                                      widget
                                                                          .itemDetails!
                                                                          .addons![
                                                                              index]
                                                                          .cover,
                                                                      widget
                                                                          .itemDetails!
                                                                          .addons![
                                                                              index]
                                                                          .variationTotalConvertPrice
                                                                          .toString(),
                                                                      widget
                                                                          .itemDetails!
                                                                          .addons![
                                                                              index]
                                                                          .totalConvertPrice);
                                                                  (context
                                                                          as Element)
                                                                      .markNeedsBuild();
                                                                }
                                                              }

                                                              calculate();
                                                              (context
                                                                      as Element)
                                                                  .markNeedsBuild();
                                                            },
                                                            child: SizedBox(
                                                              width: 140.w,
                                                              child: Text(
                                                                widget
                                                                    .itemDetails!
                                                                    .addons![
                                                                        index]
                                                                    .addonItemName
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Rubik',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      12.sp,
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: 150.w,
                                                            height: 20,
                                                            child: ListView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    itemCount: widget
                                                                        .itemDetails!
                                                                        .addons![
                                                                            index]
                                                                        .variationNames!
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            addonIndex) {
                                                                      return Text(
                                                                        "${widget.itemDetails!.addons![index].variationNames![addonIndex].name.toString()} , ",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Rubik',
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize: 10.sp,
                                                                            color: AppColor.gray),
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      );
                                                                    }),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              widget
                                                                  .itemDetails!
                                                                  .addons![
                                                                      index]
                                                                  .totalCurrencyPrice!
                                                                  .toString(),
                                                              style:
                                                                  fontRegularBold,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            cartController
                                                                    .selectedAddOnsIndex
                                                                    .contains(
                                                                        index)
                                                                ? SizedBox(
                                                                    height:
                                                                        20.h,
                                                                    width: 70.w,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            int i = addonList.indexWhere((e) =>
                                                                                e.id ==
                                                                                widget.itemDetails!.addons![index].itemAddonId);
                                                                            qty =
                                                                                addonList[i].quantity!;
                                                                            if (qty >
                                                                                1) {
                                                                              qty--;
                                                                              removeItemAddons(widget.itemDetails!.addons![index].itemAddonId, widget.itemDetails!.addons![index].itemId, widget.itemDetails!.addons![index].addonItemName, widget.itemDetails!.addons![index].addonItemConvertPrice.toString(), qty, widget.itemDetails!.addons![index].cover, i, widget.itemDetails!.addons![index].variationTotalConvertPrice.toString(), widget.itemDetails!.addons![index].totalConvertPrice);
                                                                            }
                                                                            calculate();

                                                                            (context as Element).markNeedsBuild();
                                                                          },
                                                                          child: SizedBox(
                                                                              width: 20.w,
                                                                              height: 20.h,
                                                                              child: Image.asset(
                                                                                Images.IconRemoveItem,
                                                                                fit: BoxFit.cover,
                                                                              )),
                                                                        ),
                                                                        addonList.isNotEmpty
                                                                            ? Text(
                                                                                '${addonList[addonList.indexWhere((e) => e.id == widget.itemDetails!.addons![index].itemAddonId)].quantity!}',
                                                                                style: fontMedium,
                                                                              )
                                                                            : const SizedBox.shrink(),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            int i = addonList.indexWhere((e) =>
                                                                                e.id ==
                                                                                widget.itemDetails!.addons![index].itemAddonId);
                                                                            qty =
                                                                                addonList[i].quantity!;
                                                                            qty++;
                                                                            plusItemAddons(
                                                                                widget.itemDetails!.addons![index].itemAddonId,
                                                                                widget.itemDetails!.addons![index].itemId,
                                                                                widget.itemDetails!.addons![index].addonItemName,
                                                                                widget.itemDetails!.addons![index].addonItemConvertPrice.toString(),
                                                                                qty,
                                                                                widget.itemDetails!.addons![index].cover,
                                                                                i,
                                                                                widget.itemDetails!.addons![index].variationTotalConvertPrice.toString(),
                                                                                widget.itemDetails!.addons![index].totalConvertPrice);
                                                                            calculate();
                                                                            (context as Element).markNeedsBuild();
                                                                          },
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                20.w,
                                                                            height:
                                                                                20.h,
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              Images.IconAddItem,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : const SizedBox()
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
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 16.h),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SPECIAL_INSTRUCTIONS".tr,
                              style: fontProfile,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            TextField(
                              showCursor: true,
                              readOnly: false,
                              expands: false,
                              controller: instructionTextController,
                              decoration: InputDecoration(
                                hintText: "ADD_NOTE".tr,
                                hintStyle: fontProfileLite,
                                fillColor: AppColor.searchBarbg,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0.r)),
                                  borderSide: BorderSide(
                                      color: AppColor.searchBarbg,
                                      width: 2.0.w),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0.r)),
                                  borderSide: BorderSide(
                                      width: 2.w, color: AppColor.dividerColor),
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
              Column(
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (cartController.itemQuantity == 0) {
                              customTast("PLEASE_INCREASE_QUANTITY".tr,
                                  AppColor.error);
                            } else {
                              cartController.addItem(
                                  widget.itemDetails!,
                                  extraList,
                                  variationList,
                                  totalPrice,
                                  variationSum,
                                  extraSum,
                                  instructionTextController.text);
                              cartController.addItemAddons(addonList);
                              customTast("ADDED_TO_CART".tr, AppColor.success);
                              Get.back();
                            }
                            totalPrice = 0.0;
                            variationTotal = 0.0;
                            extraTotal = 0.0;
                            (context as Element).markNeedsBuild();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColor.primaryColor,
                            minimumSize: Size(328.w, 52.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26.r),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 18.w,
                                height: 18.h,
                                child: SvgPicture.asset(
                                  Images.iconCart,
                                  fit: BoxFit.cover,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "ADD_TO_CARTS".tr,
                                style: fontMedium,
                              ),
                              SizedBox(
                                width: 10.w,
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
                                              .siteDefaultCurrencySymbol!
                                              .toString(),
                                          style: fontMedium,
                                        ),
                                        Text(
                                          cartTotal.toStringAsFixed(2),
                                          style: fontMedium,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          cartTotal.toStringAsFixed(2),
                                          style: fontMedium,
                                        ),
                                        Text(
                                          Get.find<SplashController>()
                                              .configData
                                              .siteDefaultCurrencySymbol!
                                              .toString(),
                                          style: fontMedium,
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget multiVariation(context, ItemData itemdetails) {
  List<DropdownMenuItem<String>> _addVaritionItems(items) {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item['name'].toString() + ", " + item['price'].toString(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item['name'], style: fontRegularBold),
                  Text(
                    item['price'],
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    return menuItems;
  }

  String? selectedItems;

  return GetBuilder<CartController>(
    builder: (cartController) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        //itemCount: itemdetails.itemAttributes!.length,
        itemCount: 1,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 16.w, right: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0.w, right: 8.w),
                  child: Text(
                    itemdetails.itemAttributes![index].name!,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.only(right: 16.w, bottom: 16.h, top: 4.h),
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.w,
                          color: AppColor.itembg,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                          )),
                          hint: Text(
                            'Select Options',
                            style: fontRegular,
                          ),
                          items: _addVaritionItems(
                            itemdetails.variations![itemdetails
                                .itemAttributes![index].id
                                .toString()],
                          ).toList(),
                          value: selectedItems,
                          onChanged: (value) {
                            selectedItems = value;

                            (context as Element).markNeedsBuild();
                          },
                        ),
                      ),
                    )),
              ],
            ),
          );
        }),
  );
}

Widget bottomSheetItem(ItemData itemDetails, indexNumber, context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.h, left: 16.w, right: 16.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: SizedBox(
            height: 80.h,
            width: 80.w,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              child: CachedNetworkImage(
                imageUrl: itemDetails.cover!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      // colorFilter:
                      //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  child: Container(
                      height: 130.h, width: 200.w, color: Colors.grey),
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 220.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 8.w, top: 4.h, bottom: 4.h, right: 8.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 210.w,
                            child: Text(
                              itemDetails.name!,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // SizedBox(
                          //   width: 10.w,
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     showBottomSheet(
                          //       enableDrag: false,
                          //       context: context,
                          //       backgroundColor: Colors.transparent,
                          //       builder: (context) => SingleChildScrollView(
                          //         child: ItemCaution(
                          //           itemName: itemDetails.name,
                          //           itemCaution: itemDetails.caution,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   child: SizedBox(
                          //     width: 14.w,
                          //     height: 14.h,
                          //     child: SvgPicture.asset(
                          //       Images.iconDetails,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: SvgPicture.asset(
                          Images.IconClose,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                itemDetails.description!.isNotEmpty
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: 8.w, bottom: 8.h, right: 8.w),
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          itemDetails.description.toString(),
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                            color: AppColor.gray,
                          ),
                          maxLines: 20,
                        ),
                      )
                    : SizedBox(
                        height: 65.h,
                      ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: itemDetails.offer!.isNotEmpty
                      ? Row(
                          children: [
                            Text(
                              itemDetails.currencyPrice!,
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp,
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColor.gray),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              itemDetails.offer![0].currencyPrice!,
                              style: fontMediumPro,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              itemDetails.currencyPrice!,
                              style: fontMediumPro,
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
  );
}
