import 'dart:convert';

import 'package:get/get.dart';
import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/order_details_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../home/controllers/home_controller.dart';

class PlaceOrderController extends GetxController {
  static Server server = Server();
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();
  OrderDetailsData orderDetailsData = OrderDetailsData();
  bool loader = false;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  Future<OrderDetailsModel> placeOrderPost( 
      placeOrderModel, Function callback) async {
    loader = true;
    update();
    Map body = {
      "branch_id": placeOrderModel.branchId,
      "order_type": placeOrderModel.orderType,
      "is_advance_order": placeOrderModel.isAdvanceOrder,
      "delivery_charge": placeOrderModel.deliveryCharge,
      "address_id": placeOrderModel.addressId,
      "delivery_time": placeOrderModel.deliveryTime,
      "subtotal": placeOrderModel.subtotal,
      "total": placeOrderModel.total,
      "coupon_id": placeOrderModel.couponId,
      "discount": placeOrderModel.discount,
      "source": 10,
      "items": json.encode(placeOrderModel.items).toString(),
    };
    String jsonBody = json.encode(body);
    server
        .postRequestWithToken(endPoint: APIList.order, body: jsonBody)
        .then((response) {
      if (response != null && response.statusCode == 201) {
        loader = false;
        update();
        Get.find<CartController>().cart.clear();
        final jsonResponse = json.decode(response.body);
        orderDetailsModel = OrderDetailsModel.fromJson(jsonResponse);
        orderDetailsData = orderDetailsModel.data!;
        Get.find<HomeController>().getActiveOrderList();
        Get.find<CartController>().removeCoupon();
        update();

        callback(true, orderDetailsData);
        update();
      } else {
        final jsonResponse = json.decode(response.body);
        customSnackbar("ERROR".tr, jsonResponse["message"], AppColor.error);
        update();
        Future.delayed(const Duration(milliseconds: 1000), () {
          loader = false;
          update();
        });
      }
    });
    update();
    return orderDetailsModel;
  }
}
