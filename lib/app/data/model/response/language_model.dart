// To parse this JSON data, do
//
//     final languageModel = languageModelFromJson(jsonString);

import 'dart:convert';

LanguageModel languageModelFromJson(String str) =>
    LanguageModel.fromJson(json.decode(str));

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  List<LanguageData>? data;

  LanguageModel({
    this.data,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        data: json["data"] == null
            ? []
            : List<LanguageData>.from(
                json["data"]!.map((x) => LanguageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class LanguageData {
  int? id;
  String? name;
  String? code;
  int? status;
  String? image;

  LanguageData({
    this.id,
    this.name,
    this.code,
    this.status,
    this.image,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "status": status,
        "image": image,
      };
}
