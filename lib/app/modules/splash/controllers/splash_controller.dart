// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodking/app/data/model/response/language_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/api-list.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/config_model.dart';
import '../../../data/model/response/country_code_model.dart';
import '../../../data/model/response/order_details_model.dart';
import '../../../data/model/response/page_model.dart';

class SplashController extends GetxController {
  static Server server = Server();
  final box = GetStorage();
  ConfigData configData = ConfigData();
  CountryInfoData countryInfoData = CountryInfoData();
  ConfigModel configModel = ConfigModel();
  CountryInfo countryInfo = CountryInfo();
  List<OrderDetailsData> activeOrderData = <OrderDetailsData>[];
  OrderDetailsModel activeOrderModel = OrderDetailsModel();
  bool loader = false;
  bool orderDetailsLoader = false;

  PageModel pageModelData = PageModel();
  PageData pageData = PageData();
  List<PageData> pageDataList = <PageData>[];

  LanguageModel languageModelData = LanguageModel();
  LanguageData languageData = LanguageData();
  List<LanguageData> languageDataList = <LanguageData>[];

  @override
  void onInit() {
    getConfiguration();
    getPageData();
    getLanguageData();
    super.onInit();
  }

  Future<ConfigModel?> getConfiguration() async {
    final box = GetStorage();
    try {
      await server
          .getRequestWithoutToken(endPoint: APIList.configuration)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          configModel = ConfigModel.fromJson(jsonResponse);
          configData = configModel.data!;
          update();
          box.write("countryCodeName",
              configModel.data!.companyCountryCode.toString());
          box.write("otpVarify", configData.sitePhoneVerification);
          box.write("otpLength", configData.otpDigitLimit);
          box.write("otpTime", configData.otpExpireTime);
          box.write("currencySymbol", configData.siteDefaultCurrencySymbol);
          getCountryInfo(configModel.data!.companyCountryCode.toString());
          update();
          return configModel;
        } else {
          debugPrint(response.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return configModel;
  }

  Future<CountryInfo?> getCountryInfo(String countryCode) async {
    final box = GetStorage();
    try {
      await server
          .getRequestWithoutToken(endPoint: APIList.countryInfo! + countryCode)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          countryInfo = CountryInfo.fromJson(jsonResponse);
          countryInfoData = countryInfo.data!;
          update();
          box.write("countryCode", countryInfoData.callingCode);
          box.write("countryFlag", countryInfoData.flagEmoji);
          update();
          return countryInfo;
        } else {
          debugPrint(response.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return countryInfo;
  }

  Future<PageModel> getPages() async {
    try {
      await server
          .getRequestWithoutToken(endPoint: APIList.pages!)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          pageModelData = PageModel.fromJson(jsonResponse);
          return pageModelData;
        }
      });
      return pageModelData;
    } catch (e) {
      debugPrint(e.toString());
    }
    return pageModelData;
  }

  getPageData() async {
    var responsePageData = await getPages();
    if (responsePageData.data != null) {
      pageDataList = responsePageData.data!;
      update();
    }
  }

  Future<LanguageModel> getLanguage() async {
    try {
      await server
          .getRequestWithoutToken(endPoint: APIList.language!)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          languageModelData = LanguageModel.fromJson(jsonResponse);
          return languageData;
        }
      });
      return languageModelData;
    } catch (e) {
      debugPrint(e.toString());
    }
    return languageModelData;
  }

  getLanguageData() async {
    var langData = await getLanguage();
    if (langData.data!.isNotEmpty) {
      languageDataList = langData.data!;
      update();
    }
  }
}
