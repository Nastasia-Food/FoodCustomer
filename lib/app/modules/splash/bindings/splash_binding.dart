import 'package:foodking/app/modules/home/controllers/home_controller.dart';
import 'package:foodking/app/modules/menu/controllers/menu_controller.dart';
import 'package:foodking/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import '../../address/controllers/address_controller.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../checkout/controllers/checkout_controller.dart';
import '../../checkout/controllers/coupon_controller.dart';
import '../../checkout/controllers/order_controller.dart';
import '../../offer/controllers/offer_controller.dart';
import '../../order/controllers/order_controller.dart';
import '../../search/controllers/search_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(SplashController());
    Get.put(HomeController());
    Get.put(CartController());
    Get.put(MenuuController());
    Get.put(CheckoutController());
    Get.put(SearchController());
    Get.put(OfferController());
    Get.put(CouponController());
    Get.put(PlaceOrderController());
    Get.put(AddressController());
    Get.put(ProfileController());
    Get.put(OrderController());
  }
}
