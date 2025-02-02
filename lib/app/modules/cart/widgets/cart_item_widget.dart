// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/cart_controller.dart';
import 'cart_instruction_widget.dart';
import 'cart_variation_widget.dart';

Widget cartItemSection() {
  final cartController = Get.find<CartController>();
  return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: cartController.cart.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 16, bottom: 4.h, right: 16.w),
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
                width: double.infinity,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60.w,
                        height: 60.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                          child: CachedNetworkImage(
                            imageUrl: cartController.cart[index].itemImage!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              // ignore: sort_child_properties_last
                              child: Container(
                                  height: 130, width: 200, color: Colors.grey),
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      SizedBox(
                        height: 60.h,
                        width: 260.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                cartController.cart[index].itemName.toString(),
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            //here
                            cartController.cart[index].itemVariations != null
                                ? SizedBox(
                                    width: 240.w,
                                    height: 20.h,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: cartController
                                          .cart[index].itemVariations!.length,
                                      itemBuilder: (BuildContext context, i) {
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
                            SizedBox(
                              height: 20.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                              "${cartController.cart[index].totalPrice!}"
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
                                  SizedBox(
                                    height: 20.h,
                                    width: 90.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (cartController
                                                    .cart[index].quantity ==
                                                1) {
                                              cartController.removeItem(
                                                  cartController
                                                      .cart[index].itemId);
                                              cartController
                                                  .removeItemFromCart(index);
                                              cartController.calculateTotal();
                                              (context as Element)
                                                  .markNeedsBuild();
                                            } else {
                                              cartController
                                                  .updateQuantityRemove(
                                                cartController
                                                    .cart[index].quantity!,
                                                cartController
                                                    .cart[index].itemId,
                                                cartController
                                                    .cart[index].itemName,
                                                cartController
                                                    .cart[index].itemPrice,
                                                cartController
                                                    .cart[index].itemImage,
                                                index,
                                                cartController
                                                    .cart[index].itemExtras,
                                                cartController
                                                    .cart[index].itemVariations,
                                                cartController.cart[index]
                                                    .itemVariationTotal,
                                                cartController
                                                    .cart[index].itemExtraTotal,
                                              );
                                              cartController.calculateTotal();
                                              (context as Element)
                                                  .markNeedsBuild();
                                            }
                                          },
                                          child: SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child: cartController.cart[index]
                                                        .quantity! ==
                                                    1
                                                ? SvgPicture.asset(
                                                    Images.iconTrash,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    Images.IconRemoveItem,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Text(
                                          cartController.cart[index].quantity
                                              .toString(),
                                          style: fontSemiBold,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cartController.updateQuantityAdd(
                                              cartController
                                                  .cart[index].quantity!,
                                              cartController.cart[index].itemId,
                                              cartController
                                                  .cart[index].itemName,
                                              cartController
                                                  .cart[index].itemPrice,
                                              cartController
                                                  .cart[index].itemImage,
                                              index,
                                              cartController
                                                  .cart[index].itemExtras,
                                              cartController
                                                  .cart[index].itemVariations,
                                              cartController.cart[index]
                                                  .itemVariationTotal,
                                              cartController
                                                  .cart[index].itemExtraTotal,
                                            );
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
                          ],
                        ),
                      ),
                    ]),
              ),
              cartVariationSection(index),
              cartInstructionSection(index),
              const Divider(
                thickness: 2,
                indent: 2,
                endIndent: 16,
                color: AppColor.bgColor,
              ),
            ],
          ),
        );
      });
}
