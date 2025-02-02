// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) =>
    ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigData? data;

  ConfigModel({
    this.data,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        data: json["data"] == null ? null : ConfigData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ConfigData {
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  String? companyCountryCode;
  int? siteDefaultBranch;
  int? siteDefaultLanguage;
  int? siteCurrencyPosition;
  String? siteDigitAfterDecimalPoint;
  String? siteDefaultCurrencySymbol;
  int? sitePhoneVerification;
  String? otpType;
  String? otpDigitLimit;
  String? otpExpireTime;
  String? orderSetupFoodPreparationTime;
  int? orderSetupTakeaway;
  int? orderSetupDelivery;
  String? orderSetupFreeDeliveryKilometer;
  String? orderSetupBasicDeliveryCharge;
  String? orderSetupChargePerKilo;
  int? siteOnlinePaymentGateway;

  ConfigData({
    this.companyName,
    this.companyEmail,
    this.companyPhone,
    this.companyCountryCode,
    this.siteDefaultBranch,
    this.siteDefaultLanguage,
    this.siteCurrencyPosition,
    this.siteDigitAfterDecimalPoint,
    this.siteDefaultCurrencySymbol,
    this.sitePhoneVerification,
    this.otpType,
    this.otpDigitLimit,
    this.otpExpireTime,
    this.orderSetupFoodPreparationTime,
    this.orderSetupTakeaway,
    this.orderSetupDelivery,
    this.orderSetupFreeDeliveryKilometer,
    this.orderSetupBasicDeliveryCharge,
    this.orderSetupChargePerKilo,
    this.siteOnlinePaymentGateway,
  });

  factory ConfigData.fromJson(Map<String, dynamic> json) => ConfigData(
        companyName: json["company_name"],
        companyEmail: json["company_email"],
        companyPhone: json["company_phone"],
        companyCountryCode: json["company_country_code"],
        siteDefaultBranch: json["site_default_branch"],
        siteDefaultLanguage: json["site_default_language"],
        siteCurrencyPosition: json["site_currency_position"],
        siteDigitAfterDecimalPoint: json["site_digit_after_decimal_point"],
        siteDefaultCurrencySymbol: json["site_default_currency_symbol"],
        sitePhoneVerification: json["site_phone_verification"],
        otpType: json["otp_type"],
        otpDigitLimit: json["otp_digit_limit"],
        otpExpireTime: json["otp_expire_time"],
        orderSetupFoodPreparationTime:
            json["order_setup_food_preparation_time"],
        orderSetupTakeaway: json["order_setup_takeaway"],
        orderSetupDelivery: json["order_setup_delivery"],
        orderSetupFreeDeliveryKilometer:
            json["order_setup_free_delivery_kilometer"],
        orderSetupBasicDeliveryCharge:
            json["order_setup_basic_delivery_charge"],
        orderSetupChargePerKilo: json["order_setup_charge_per_kilo"],
        siteOnlinePaymentGateway: json["site_online_payment_gateway"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "company_email": companyEmail,
        "company_phone": companyPhone,
        "company_country_code": companyCountryCode,
        "site_default_branch": siteDefaultBranch,
        "site_default_language": siteDefaultLanguage,
        "site_currency_position": siteCurrencyPosition,
        "site_digit_after_decimal_point": siteDigitAfterDecimalPoint,
        "site_default_currency_symbol": siteDefaultCurrencySymbol,
        "site_phone_verification": sitePhoneVerification,
        "otp_type": otpType,
        "otp_digit_limit": otpDigitLimit,
        "otp_expire_time": otpExpireTime,
        "order_setup_food_preparation_time": orderSetupFoodPreparationTime,
        "order_setup_takeaway": orderSetupTakeaway,
        "order_setup_delivery": orderSetupDelivery,
        "order_setup_free_delivery_kilometer": orderSetupFreeDeliveryKilometer,
        "order_setup_basic_delivery_charge": orderSetupBasicDeliveryCharge,
        "order_setup_charge_per_kilo": orderSetupChargePerKilo,
        "site_online_payment_gateway": siteOnlinePaymentGateway,
      };
}
