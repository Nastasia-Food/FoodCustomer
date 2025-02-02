// To parse this JSON data, do
//
//     final offerItemModel = offerItemModelFromJson(jsonString);

import 'dart:convert';

OfferModel offerItemModelFromJson(String str) =>
    OfferModel.fromJson(json.decode(str));

String offerItemModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
  List<OfferData>? data;

  OfferModel({
    this.data,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        data: json["data"] == null
            ? []
            : List<OfferData>.from(
                json["data"]!.map((x) => OfferData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OfferData {
  int? id;
  String? name;
  String? slug;
  String? amount;
  String? flatAmount;
  int? convertAmount;
  String? convertStartDate;
  String? convertEndDate;
  DateTime? startDate;
  DateTime? endDate;
  int? status;
  String? image;

  OfferData({
    this.id,
    this.name,
    this.slug,
    this.amount,
    this.flatAmount,
    this.convertAmount,
    this.convertStartDate,
    this.convertEndDate,
    this.startDate,
    this.endDate,
    this.status,
    this.image,
  });

  factory OfferData.fromJson(Map<String, dynamic> json) => OfferData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        amount: json["amount"],
        flatAmount: json["flat_amount"],
        convertAmount: json["convert_amount"],
        convertStartDate: json["convert_start_date"],
        convertEndDate: json["convert_end_date"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "amount": amount,
        "flat_amount": flatAmount,
        "convert_amount": convertAmount,
        "convert_start_date": convertStartDate,
        "convert_end_date": convertEndDate,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "image": image,
      };
}
