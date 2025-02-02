import 'package:get/get.dart';
import '../../address/controllers/address_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../checkout/controllers/checkout_controller.dart';
import '../../checkout/controllers/coupon_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../menu/controllers/menu_controller.dart';
import '../../offer/controllers/offer_controller.dart';
import '../../order/controllers/order_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../search/controllers/search_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
    Get.put(OfferController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(MenuuController(), permanent: true);
    Get.put(OrderController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(AddressController(), permanent: true);
    Get.put(CheckoutController(), permanent: true);
    Get.put(SearchController(), permanent: true);
    Get.put(CouponController(), permanent: true);
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}
