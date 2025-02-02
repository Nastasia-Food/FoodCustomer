import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/config_model.dart';
import '../model/response/country_code_model.dart';

class ConfigRepo {
  static Server server = Server();
  static ConfigModel configModel = ConfigModel();
  static CountryInfo countryInfo = CountryInfo();

  static Future<ConfigModel?> getConfiguration() async {
    final box = GetStorage();
    try {
      await server
          .getRequestWithoutToken(endPoint: APIList.configuration)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          configModel = ConfigModel.fromJson(jsonResponse);
          box.write("countryCodeName",
              configModel.data!.companyCountryCode.toString());
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

  static Future<CountryInfo?> getCountryInfo() async {
    final box = GetStorage();
    try {
      await server
          .getRequestWithoutToken(
              endPoint: APIList.countryInfo! + box.read('countryCodeName'))
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          countryInfo = CountryInfo.fromJson(jsonResponse);

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
}
