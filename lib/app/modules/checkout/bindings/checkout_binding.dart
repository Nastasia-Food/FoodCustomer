import 'package:get/get.dart';
import '../../address/controllers/address_controller.dart';
import '../controllers/checkout_controller.dart';
import '../controllers/coupon_controller.dart';
import '../controllers/order_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaceOrderController>(
      () => PlaceOrderController(),
    );
    Get.lazyPut<CouponController>(
      () => CouponController(),
    );
    Get.lazyPut<AddressController>(
      () => AddressController(),
    );
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
  }
}
