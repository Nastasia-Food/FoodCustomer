// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../widget/custom_toast.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/order_details_model.dart';
import '../../../data/model/response/order_mode.dart';
import '../../../data/repository/my_order_repo.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../home/controllers/home_controller.dart';
import '../views/order_details.dart';

class OrderController extends GetxController {
  final box = GetStorage();
  static Server server = Server();
  List<OrdersData> ordersData = <OrdersData>[];
  final orderDetailsData = OrderDetailsData().obs;
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();
  bool loader = false;
  final orderDetailsLoader = false.obs;
  int? orderId;

  final activeStep = 0.obs;

  final orderNotificationId = "".obs;
  final orderNotfyLoader = false.obs;

  @override
  void onInit() {
    final box = GetStorage();
    if (box.read('isLogedIn') == true && box.read('isLogedIn') != null) {
      getMyOrderList();
    }
    super.onInit();
  }

  getMyOrderList() async {
    loader = true;
    update();
    if (box.read('isLogedIn') != null && box.read('isLogedIn') != false) {
      var myOrderData = await MyOrderRepo.getMyOrder();
      if (myOrderData != null) {
        ordersData = myOrderData.data!;
        loader = false;
        update();
      } else {
        loader = false;
        update();
      }
    } else {
      loader = false;
      update();
    }
  }

  Future<OrderDetailsModel?> getOrderDetails(int id) async {
    orderId = id;

    orderDetailsLoader.value = true;

    try {
      await server
          .getRequest(endPoint: APIList.orderDetails! + id.toString())
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          orderDetailsModel = OrderDetailsModel.fromJson(jsonResponse);
          orderDetailsData.value = orderDetailsModel.data!;

          orderDetailsLoader.value = false;

          Get.to(() => OrderDetailsView(
                orderId: id,
              ));

          if (orderDetailsData.value.status! == 1) {
            activeStep.value = 0;
          } else if (orderDetailsData.value.status! == 4) {
            activeStep.value = 1;
          } else if (orderDetailsData.value.status! == 7) {
            activeStep.value = 2;
          } else if (orderDetailsData.value.status! == 10) {
            activeStep.value = 3;
          } else if (orderDetailsData.value.status! == 13) {
            activeStep.value = 4;
          }

          return orderDetailsModel;
        } else {
          orderDetailsLoader.value = false;
          //   update();
        }
      });
      return orderDetailsModel;
    } catch (e) {
      orderDetailsLoader.value = false;
      //   update();
    }
  }

  Future<OrderDetailsModel?> orderCancel(id) async {
    orderDetailsLoader.value = true;
    update();
    try {
      Map body = {
        'status': 16,
      };
      String jsonBody = json.encode(body);

      await server
          .postRequestWithToken(
              endPoint: APIList.cancelOrder! + id.toString(), body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          orderDetailsModel = OrderDetailsModel.fromJson(jsonResponse);
          orderDetailsData.value = orderDetailsModel.data!;
          update();
          orderDetailsLoader.value = false;
          update();
          getMyOrderList();
          Get.find<HomeController>().getActiveOrderList();
          update();
          Future.delayed(const Duration(milliseconds: 200), () {
            Get.offAll(() => const DashboardView());
            update();
          });

          customTast("ORDER_HAS_BEEN_CANCELLED".tr, AppColor.success);

          return orderDetailsModel;
        } else {
          orderDetailsLoader.value = false;
          update();
        }
      });
      return orderDetailsModel;
    } catch (e) {
      orderDetailsLoader.value = false;
      update();
    }
  }
}
