// To parse this JSON data, do
//
//     final couponCheckModel = couponCheckModelFromJson(jsonString);

import 'dart:convert';

CouponCheckModel couponCheckModelFromJson(String str) =>
    CouponCheckModel.fromJson(json.decode(str));

String couponCheckModelToJson(CouponCheckModel data) =>
    json.encode(data.toJson());

class CouponCheckModel {
  CouponCheckModel({
    this.data,
  });

  CouponCheckData? data;

  factory CouponCheckModel.fromJson(Map<String, dynamic> json) =>
      CouponCheckModel(
        data: json["data"] == null
            ? null
            : CouponCheckData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class CouponCheckData {
  CouponCheckData({
    this.id,
    this.code,
    this.discount,
    this.flatDiscount,
    this.convertDiscount,
    this.currencyDiscount,
  });

  int? id;
  String? code;
  double? discount;
  double? flatDiscount;
  double? convertDiscount;
  String? currencyDiscount;

  factory CouponCheckData.fromJson(Map<String, dynamic> json) =>
      CouponCheckData(
        id: json["id"],
        code: json["code"],
        discount: double.parse(json["discount"].toString()),
        flatDiscount: double.parse(json["flat_discount"].toString()),
        convertDiscount: double.parse(json["convert_discount"].toString()),
        currencyDiscount: json["currency_discount"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "discount": discount,
        "flat_discount": flatDiscount,
        "convert_discount": convertDiscount,
        "currency_discount": currencyDiscount,
      };
}
