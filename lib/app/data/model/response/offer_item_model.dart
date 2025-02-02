// To parse this JSON data, do
//
//     final offerItemModel = offerItemModelFromJson(jsonString);

import 'dart:convert';

import 'item_model.dart';

OfferItemModel offerItemModelFromJson(String str) =>
    OfferItemModel.fromJson(json.decode(str));

String offerItemModelToJson(OfferItemModel data) => json.encode(data.toJson());

class OfferItemModel {
  OfferItemData? data;

  OfferItemModel({
    this.data,
  });

  factory OfferItemModel.fromJson(Map<String, dynamic> json) => OfferItemModel(
        data:
            json["data"] == null ? null : OfferItemData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class OfferItemData {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? status;
  String? thumb;
  String? cover;
  String? image;
  List<ItemData>? items;

  OfferItemData({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.status,
    this.thumb,
    this.cover,
    this.items,
    this.image,
  });

  factory OfferItemData.fromJson(Map<String, dynamic> json) => OfferItemData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        status: json["status"],
        thumb: json["thumb"],
        cover: json["cover"],
        image: json["image"],
        items: json["items"] == null
            ? []
            : List<ItemData>.from(
                json["items"]!.map((x) => ItemData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "status": status,
        "thumb": thumb,
        "cover": cover,
        "image": image,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
