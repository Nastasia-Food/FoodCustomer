// To parse this JSON data, do
//
//     final countryCode = countryCodeFromJson(jsonString);

import 'dart:convert';

CountryInfo countryCodeFromJson(String str) =>
    CountryInfo.fromJson(json.decode(str));

String countryCodeToJson(CountryInfo data) => json.encode(data.toJson());

class CountryInfo {
  CountryInfo({
    this.data,
  });

  CountryInfoData? data;

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
        data: json["data"] == null
            ? null
            : CountryInfoData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class CountryInfoData {
  CountryInfoData({
    this.callingCode,
    this.flagEmoji,
    this.flagSvg,
    this.flagSvgPath,
    this.capital,
    this.nationality,
  });

  String? callingCode;
  String? flagEmoji;
  String? flagSvg;
  String? flagSvgPath;
  String? capital;
  String? nationality;

  factory CountryInfoData.fromJson(Map<String, dynamic> json) =>
      CountryInfoData(
        callingCode: json["calling_code"],
        flagEmoji: json["flag_emoji"],
        flagSvg: json["flag_svg"],
        flagSvgPath: json["flag_svg_path"],
        capital: json["capital"],
        nationality: json["nationality"],
      );

  Map<String, dynamic> toJson() => {
        "calling_code": callingCode,
        "flag_emoji": flagEmoji,
        "flag_svg": flagSvg,
        "flag_svg_path": flagSvgPath,
        "capital": capital,
        "nationality": nationality,
      };
}
