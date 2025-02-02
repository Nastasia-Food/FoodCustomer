import 'dart:convert';
import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/coupon_check_model.dart';
import '../model/response/coupon_model.dart';

class CouponRepo {
  static Server server = Server();
  CouponCheckModel couponCheckModel = CouponCheckModel();
  static CouponModel couponModelData = CouponModel();

  static Future<CouponModel?> getCoupon() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.couponList,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          couponModelData = CouponModel.fromJson(jsonResponse);
          return couponModelData;
        }
      });
      return couponModelData;
    } catch (e) {
      return null;
    }
  }
}
