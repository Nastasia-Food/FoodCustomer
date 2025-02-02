// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:get/get.dart';

import '../modules/address/bindings/address_binding.dart';

import '../modules/address/widget/addAddress/add_pick_location_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/item/bindings/item_binding.dart';
import '../modules/item/views/item_view.dart';
import '../modules/menu/bindings/menu_binding.dart';
import '../modules/menu/views/menu_view.dart';
import '../modules/offer/bindings/offer_binding.dart';
import '../modules/offer/views/offer_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.OFFER,
      page: () => OfferView(),
      binding: OfferBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => MenuView(
        fromHome: false,
        categoryId: 0,
      ),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ITEM,
      page: () => ItemView(),
      binding: ItemBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(
        fromNav: true,
      ),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    // GetPage(
    //   name: _Paths.ADDRESS,
    //   page: () => AddressView(),
    //   binding: AddressBinding(),
    // ),
    // GetPage(
    //   name: _Paths.EDIT_ADDRESS,
    //   page: () => EditAddressView(),
    //   binding: AddressBinding(),
    // ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PICK_LOCATION,
      page: () => AddPickLocationView(),
      binding: AddressBinding(),
    ),
  ];
}
