// To parse this JSON data, do
//
//     final categoryWiseItemModel = categoryWiseItemModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

import 'item_model.dart';

CategoryWiseItemModel categoryWiseItemModelFromJson(String str) =>
    CategoryWiseItemModel.fromJson(json.decode(str));

String categoryWiseItemModelToJson(CategoryWiseItemModel data) =>
    json.encode(data.toJson());

class CategoryWiseItemModel {
  CategoryWiseItemModel({
    this.data,
  });

  CategoryWiseItemData? data;

  factory CategoryWiseItemModel.fromJson(Map<String, dynamic> json) =>
      CategoryWiseItemModel(
        data: json["data"] == null
            ? null
            : CategoryWiseItemData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class CategoryWiseItemData {
  CategoryWiseItemData({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.status,
    this.image,
    this.items,
  });

  int? id;
  String? name;
  String? slug;
  String? description;
  int? status;
  String? image;
  List<ItemData>? items;

  factory CategoryWiseItemData.fromJson(Map<String, dynamic> json) =>
      CategoryWiseItemData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        description: json["description"] == null ? null : json["description"],
        status: json["status"] == null ? null : json["status"],
        image: json["image"] == null ? null : json["image"],
        items: json["items"] == null
            ? null
            : List<ItemData>.from(
                json["items"].map((x) => ItemData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "description": description == null ? null : description,
        "status": status == null ? null : status,
        "image": image == null ? null : image,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
