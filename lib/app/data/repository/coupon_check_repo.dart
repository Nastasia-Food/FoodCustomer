import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/api-list.dart';
import '../../../widget/custom_snackbar.dart';
import '../api/server.dart';
import '../model/response/coupon_check_model.dart';

class AuthRepo {
  Server server = Server();
  CouponCheckModel couponCheckModel = CouponCheckModel();

  Future<CouponCheckModel?> checkCoupon(
      {String? email, String? password}) async {
    Map body = {'total': email, 'code': password};
    String jsonBody = json.encode(body);
    try {
      server
          .postRequest(endPoint: APIList.checkCoupon, body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          couponCheckModel = CouponCheckModel.fromJson(jsonResponse);
          return couponCheckModel;
        } else {
          customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, Colors.red);
          return null;
        }
      });
      return couponCheckModel;
    } catch (e) {
      return null;
    }
  }
}
