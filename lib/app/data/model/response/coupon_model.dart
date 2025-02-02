// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  CouponModel({
    this.data,
  });

  List<CouponData>? data;

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        data: json["data"] == null
            ? []
            : List<CouponData>.from(
                json["data"]!.map((x) => CouponData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CouponData {
  CouponData({
    this.id,
    this.name,
    this.description,
    this.code,
    this.discount,
    this.flatDiscount,
    this.convertDiscount,
    this.currencyDiscount,
    this.discountType,
    this.convertStartDate,
    this.convertEndDate,
    this.startDate,
    this.endDate,
    this.minimumOrder,
    this.minimumOrderFlatAmount,
    this.minimumOrderConvertAmount,
    this.minimumOrderCurrencyAmount,
    this.maxmiumDiscount,
    this.maxmiumFlatDiscount,
    this.maxmiumConvertDiscount,
    this.maxmiumCurrencyDiscount,
    this.limitPerUser,
    this.image,
  });

  int? id;
  String? name;
  String? description;
  String? code;
  String? discount;
  String? flatDiscount;
  int? convertDiscount;
  String? currencyDiscount;
  int? discountType;
  String? convertStartDate;
  String? convertEndDate;
  DateTime? startDate;
  DateTime? endDate;
  String? minimumOrder;
  String? minimumOrderFlatAmount;
  int? minimumOrderConvertAmount;
  String? minimumOrderCurrencyAmount;
  String? maxmiumDiscount;
  String? maxmiumFlatDiscount;
  int? maxmiumConvertDiscount;
  String? maxmiumCurrencyDiscount;
  int? limitPerUser;
  String? image;

  factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        code: json["code"],
        discount: json["discount"],
        flatDiscount: json["flat_discount"],
        convertDiscount: json["convert_discount"],
        currencyDiscount: json["currency_discount"],
        discountType: json["discount_type"],
        convertStartDate: json["convert_start_date"],
        convertEndDate: json["convert_end_date"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        minimumOrder: json["minimum_order"],
        minimumOrderFlatAmount: json["minimum_order_flat_amount"],
        minimumOrderConvertAmount: json["minimum_order_convert_amount"],
        minimumOrderCurrencyAmount: json["minimum_order_currency_amount"],
        maxmiumDiscount: json["maxmium_discount"],
        maxmiumFlatDiscount: json["maxmium_flat_discount"],
        maxmiumConvertDiscount: json["maxmium_convert_discount"],
        maxmiumCurrencyDiscount: json["maxmium_currency_discount"],
        limitPerUser: json["limit_per_user"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "code": code,
        "discount": discount,
        "flat_discount": flatDiscount,
        "convert_discount": convertDiscount,
        "currency_discount": currencyDiscount,
        "discount_type": discountType,
        "convert_start_date": convertStartDate,
        "convert_end_date": convertEndDate,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "minimum_order": minimumOrder,
        "minimum_order_flat_amount": minimumOrderFlatAmount,
        "minimum_order_convert_amount": minimumOrderConvertAmount,
        "minimum_order_currency_amount": minimumOrderCurrencyAmount,
        "maxmium_discount": maxmiumDiscount,
        "maxmium_flat_discount": maxmiumFlatDiscount,
        "maxmium_convert_discount": maxmiumConvertDiscount,
        "maxmium_currency_discount": maxmiumCurrencyDiscount,
        "limit_per_user": limitPerUser,
        "image": image,
      };
}
