// ignore_for_file: avoid_function_literals_in_foreach_calls, unnecessary_overrides

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:foodcustomer/app/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';
import '../../../../util/api-list.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../data/api/server.dart';
import '../../../data/model/body/place_order_body.dart';
import '../../../data/model/response/add_cart_model.dart';
import '../../../data/model/response/coupon_check_model.dart';
import '../../../data/model/response/item_model.dart';
import '../../../data/repository/coupon_repo.dart';
import '../../address/controllers/address_controller.dart';
import '../../home/controllers/home_controller.dart';

class CartController extends GetxController {
  // CouponController couponController = Get.put(CouponController());

  bool itemLoader = true;
  List<dynamic> selectedAddOns = [];
  List<int> selectedAddOnsIndex = [];
  List<int> selectedExtraIndex = [];
  List<int> selectedVariationIndex = [];
  List<dynamic> selectedItem = [];
  int selectedSingleVariationIndex = 0;
  List<dynamic>? selectedDish = [];

  int itemQuantity = 1;
  int addOnsQuantity = 1;
  double totalCartValue = 0;
  double deliveryCharge = 0.0;
  double total = 0;
  int orderTypeIndex = 0;

  double totalQunty = 0;
  double kilometer = 0;
  double maxFreeDistance = 0; // in kilometers

  List<MainItem> cartItemList = [];
  List<AddonsItem> addonList = [];
  List<Cart> cart = [];

  //coupon code
  bool couponAplied = false;
  double couponDiscount = 0.0;
  String couponCode = '';
  int? couponId = 0;
  bool couponLoading = false;
  CouponRepo couponRepo = CouponRepo();
  static Server server = Server();
  CouponCheckModel couponCheckModel = CouponCheckModel();
  CouponCheckData couponCheckData = CouponCheckData();
  final TextEditingController couponTextController = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  SplashController splash = Get.put(SplashController());

  @override
  void onInit() {
    super.onInit();
    splash.getConfiguration();
  }

  //for main item
  addQuantity() {
    itemQuantity++;
    update();
  }

  removeQuantity() {
    if (itemQuantity > 0) {
      itemQuantity--;
    }
    update();
  }

  addItem(ItemData mainItem, extra, variationList, totalPrice, variationSum,
      extraSum, instruction) {
    cart.add(Cart(
        itemId: mainItem.id,
        itemName: mainItem.name,
        itemPrice: mainItem.offer!.isEmpty
            ? mainItem.convertPrice
            : mainItem.offer![0].convertPrice,
        branchId: homeController.selectedbranchId,
        itemImage: mainItem.cover,
        quantity: itemQuantity,
        discount: couponDiscount,
        instruction: instruction,
        totalPrice: mainItem.offer!.isEmpty
            ? mainItem.convertPrice! + variationSum + extraSum
            : mainItem.offer![0].convertPrice! + variationSum + extraSum,
        itemVariationTotal: variationSum,
        itemExtraTotal: extraSum,
        itemExtras: extra,
        itemVariations: variationList));

    selectedExtraIndex.clear();
    selectedAddOnsIndex.clear();
    itemQuantity = 1;
    update();
    calculateTotal();
    update();
  }

  addItemAddons(addonItem) {
    addonItem.forEach((a) {
      cart.add(Cart(
        itemId: a.id,
        itemName: a.name,
        itemPrice: a.price,
        branchId: homeController.selectedbranchId,
        itemImage: a.image,
        quantity: a.quantity,
        discount: couponDiscount,
        totalPrice: a.price + a.itemVariationTotal,
        itemVariationTotal: a.itemVariationTotal,
        itemExtraTotal: a.itemExtraTotal,
        itemExtras: null,
        itemVariations: null,
      ));
    });

    calculateTotal();
    update();
  }

  removeItemFromCart(index) {
    cart.removeAt(index);
    update();
  }

  updateQuantityRemove(qty, id, name, price, image, index, extras,
      variationList, itemVariationTotal, itemExtraTotal) {
    if (qty > 0) {
      qty--;
    }
    cart[index] = (Cart(
        itemId: id,
        itemName: name,
        itemPrice: price,
        branchId: homeController.selectedbranchId,
        itemImage: image,
        quantity: qty,
        discount: couponDiscount,
        totalPrice: price + itemVariationTotal + itemExtraTotal,
        itemVariationTotal: itemVariationTotal,
        itemExtraTotal: itemExtraTotal,
        itemExtras: extras,
        itemVariations: variationList));

    calculateTotal();
    update();
  }

  updateQuantityAdd(qty, id, name, price, image, index, extras, variationList,
      itemVariationTotal, itemExtraTotal) {
    qty++;

    cart[index] = (Cart(
        itemId: id,
        itemName: name,
        itemPrice: price,
        branchId: homeController.selectedbranchId,
        itemImage: image,
        quantity: qty,
        discount: couponDiscount,
        totalPrice: price + itemVariationTotal + itemExtraTotal,
        itemVariationTotal: itemVariationTotal,
        itemExtraTotal: itemExtraTotal,
        itemExtras: extras,
        itemVariations: variationList));
    calculateTotal();
    update();
  }

  removeItem(id) {
    cartItemList.removeWhere((item) => item.id == id);
    update();
  }

  // total calculation
  void calculateTotal() {
    totalCartValue = 0.0;
    totalQunty = 0;
    cart.forEach((f) {
      totalCartValue +=
          (f.itemPrice! + f.itemExtraTotal! + f.itemVariationTotal!) *
              f.quantity!;
      totalQunty += f.quantity!;
    });
    if (Get.find<AddressController>().addressDataList.isNotEmpty) {
      total = deliveryCharge + totalCartValue - couponDiscount;
    } else {
      total = totalCartValue - couponDiscount;
    }
  }

  calculateDistance(lat1, lon1, lat2, lon2) {
    deliveryCharge =
        double.parse(splash.configData.orderSetupBasicDeliveryCharge.toString());
    // deliveryCharge = 0.0;

    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    kilometer = 6371 * asin(sqrt(a));
    distanceWiseDeliveryCharge();
    return kilometer.toStringAsFixed(2);

    //print('distance ----------------------- ${kilometer.toStringAsFixed(2)}');
  }

  distanceWiseDeliveryCharge() {
    splash.getConfiguration();
    deliveryCharge =
        double.parse(splash.configData.orderSetupBasicDeliveryCharge.toString());
    double chargePerKm =
        double.parse(splash.configData.orderSetupChargePerKilo.toString());

    maxFreeDistance =
        double.parse(splash.configData.orderSetupFreeDeliveryKilometer.toString());
    if (maxFreeDistance <= kilometer) {
      double extraDistance = kilometer - maxFreeDistance;
      double extraCharge = extraDistance * chargePerKm;
      deliveryCharge = deliveryCharge + extraCharge;
      //return deliveryCharge + extraCharge;

      //deliveryCharge += 2 * (kilometer - 1);
      deliveryCharge = double.parse((deliveryCharge + extraCharge).toString());
    }
    if (Get.find<AddressController>().addressDataList.isEmpty) {
      deliveryCharge = 0;
    }
    if (orderTypeIndex == 0) {
      total = deliveryCharge + totalCartValue;
    } else if (orderTypeIndex == 1) {
      total = totalCartValue;
      deliveryCharge = 0.0;
    } else if (orderTypeIndex == 10) {
      total = totalCartValue;
      deliveryCharge = 0.0;
    }
  }

  Future<CouponCheckModel?> checkCoupon() async {
    couponLoading = true;
    update();
    Map body = {'total': totalCartValue, 'code': couponTextController.text};
    String jsonBody = json.encode(body);
    try {
      server
          .postRequestWithToken(endPoint: APIList.checkCoupon, body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          couponLoading = false;
          update();
          final jsonResponse = json.decode(response.body);
          couponCheckModel = CouponCheckModel.fromJson(jsonResponse);
          couponCode = couponCheckModel.data!.code!;
          couponId = couponCheckModel.data!.id!;
          couponDiscount = couponCheckModel.data!.convertDiscount!;
          couponAplied = true;
          couponLoading = false;
          calculateTotal();
          update();
          Get.back();
          return couponCheckModel;
        } else {
          couponLoading = false;
          update();
          final jsonResponse = json.decode(response.body);
          String errorMessage = jsonResponse['message'].toString();
          customSnackbar("ERROR".tr, errorMessage, Colors.red);
          return null;
        }
      });
      return couponCheckModel;
    } catch (e) {
      couponLoading = false;
      return customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, Colors.red);
    }
  }

  removeCoupon() {
    couponTextController.clear();
    couponAplied = false;
    couponDiscount = 0.0;
    couponCode = '';
    couponId = 0;
    update();
    calculateTotal();
    update();
  }
}
