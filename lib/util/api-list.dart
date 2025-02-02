// ignore_for_file: file_names

class APIList {
  static String? mapApiKey = "AIzaSyB3S4fcKMcU-Ll9RSPkCiwdk1jXPmrTC_c";
  static String? licenseCode = "b6d68vy2-m7g5-20r0-5275-h103w73453q120";
  static String? baseUrl = "https://demo.foodking.dev";
  static String? paymentUrl = "${baseUrl!}/payment/";
  static String? login = "${baseUrl!}/api/auth/login";
  static String? otpSignUp = "${baseUrl!}/api/auth/signup/otp";
  static String? otpVarify = "${baseUrl!}/api/auth/signup/verify";
  static String? register = "${baseUrl!}/api/auth/signup/register";
  static String? guestOtpSignUp = "${baseUrl!}/api/auth/guest-signup/otp";
  static String? guestOtpVarify = "${baseUrl!}/api/auth/guest-signup/verify";
  static String? guestRegister = "${baseUrl!}/api/auth/signup/register";
  static String? forgetPassword = "${baseUrl!}/api/auth/forgot-password";
  static String? passwordResetVarifyCode =
      "${baseUrl!}/api/auth/forgot-password/verify-code";
  static String? passwordReset =
      "${baseUrl!}/api/auth/forgot-password/reset-password";
  static String? profile = "${baseUrl!}/api/profile";
  static String? changeProfileImage = "${baseUrl!}/api/profile/change-image";
  static String? updateProfile = "${baseUrl!}/api/profile/update";
  static String? changePassword = "${baseUrl!}/api/profile/change-password";
  static String? offer = "${baseUrl!}/api/frontend/offer";
  static String? offerItems = "${baseUrl!}/api/frontend/offer/show/";
  static String? category = "${baseUrl!}/api/frontend/item-category";
  static String? categoryWiseItem =
      "${baseUrl!}/api/frontend/item-category/show/";
  static String? branch = "${baseUrl!}/api/frontend/branch";
  static String? itemList = "${baseUrl!}/api/frontend/item";
  static String? popularItems = "${baseUrl!}/api/frontend/item/popular-items";
  static String? featuredItems = "${baseUrl!}/api/frontend/item/featured-items";
  static String? order = "${baseUrl!}/api/frontend/order";
  static String? orderDetails = "${baseUrl!}/api/frontend/order/show/";
  static String? addressList = "${baseUrl!}/api/frontend/address";
  static String? addressSave = "${baseUrl!}/api/frontend/address";
  static String? addressDelete = "${baseUrl!}/api/frontend/address/";
  static String? addressUpdate = "${baseUrl!}/api/frontend/address/";
  static String? todayTimeSlot = "${baseUrl!}/api/frontend/time-slot/today";
  static String? tomorrowTimeSlot =
      "${baseUrl!}/api/frontend/time-slot/tomorrow";
  static String? couponList = "${baseUrl!}/api/frontend/coupon";
  static String? checkCoupon =
      "${baseUrl!}/api/frontend/coupon/coupon-checking";
  static String? configuration = "${baseUrl!}/api/frontend/setting";
  static String? countryInfo = "${baseUrl!}/api/frontend/country-code/show/";
  static String? cancelOrder = "${baseUrl!}/api/frontend/order/change-status/";
  static String? activeOrder =
      "${baseUrl!}/api/frontend/order?excepts=13|16|19|22?order_by=asc";
  static String? token = "${baseUrl!}/api/frontend/device-token/mobile";
  static String? refreshToken = "${baseUrl!}/api/refresh-token?token=";
  static String? pages = "${baseUrl!}/api/frontend/page";
  static String? language = "${baseUrl!}/api/frontend/language";
  static String? deleteAccount = "${baseUrl!}/api/auth/delete-account";
}
