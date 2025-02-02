// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  ItemModel({
    this.data,
  });

  List<ItemData>? data;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        data: json["data"] == null
            ? []
            : List<ItemData>.from(
                json["data"]!.map((x) => ItemData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ItemData {
  ItemData({
    this.id,
    this.name,
    this.slug,
    this.flatPrice,
    this.convertPrice,
    this.currencyPrice,
    this.price,
    this.itemType,
    this.status,
    this.description,
    this.caution,
    this.thumb,
    this.cover,
    this.preview,
    this.variations,
    this.itemAttributes,
    this.extras,
    this.addons,
    this.offer,
  });

  int? id;
  String? name;
  String? slug;
  String? flatPrice;
  double? convertPrice;
  String? currencyPrice;
  String? price;
  int? itemType;
  int? status;
  String? description;
  String? caution;
  String? thumb;
  String? cover;
  String? preview;
  dynamic variations;
  List<ItemAttribute>? itemAttributes;
  List<Extra>? extras;
  List<Addon>? addons;
  List<Offer>? offer;

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        flatPrice: json["flat_price"],
        convertPrice: json["convert_price"]?.toDouble(),
        currencyPrice: json["currency_price"],
        price: json["price"],
        itemType: json["item_type"],
        status: json["status"],
        description: json["description"],
        caution: json["caution"],
        thumb: json["thumb"],
        cover: json["cover"],
        preview: json["preview"],
        variations: json["variations"],
        itemAttributes: json["itemAttributes"] == null
            ? []
            : List<ItemAttribute>.from(
                json["itemAttributes"]!.map((x) => ItemAttribute.fromJson(x))),
        extras: json["extras"] == null
            ? []
            : List<Extra>.from(json["extras"]!.map((x) => Extra.fromJson(x))),
        addons: json["addons"] == null
            ? []
            : List<Addon>.from(json["addons"]!.map((x) => Addon.fromJson(x))),
        offer: json["offer"] == null
            ? []
            : List<Offer>.from(json["offer"]!.map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "flat_price": flatPrice,
        "convert_price": convertPrice,
        "currency_price": currencyPrice,
        "price": price,
        "item_type": itemType,
        "status": status,
        "description": description,
        "caution": caution,
        "thumb": thumb,
        "cover": cover,
        "preview": preview,
        "variations": variations,
        "itemAttributes": itemAttributes == null
            ? []
            : List<dynamic>.from(itemAttributes!.map((x) => x.toJson())),
        "extras": extras == null
            ? []
            : List<dynamic>.from(extras!.map((x) => x.toJson())),
        "addons": addons == null
            ? []
            : List<dynamic>.from(addons!.map((x) => x.toJson())),
        "offer": offer == null
            ? []
            : List<dynamic>.from(offer!.map((x) => x.toJson())),
      };
}

class Addon {
  Addon(
      {this.id,
      this.itemId,
      this.itemAddonId,
      this.itemName,
      this.addonItemName,
      this.addonItemPrice,
      this.addonItemFlatPrice,
      this.addonItemConvertPrice,
      this.addonItemCurrencyPrice,
      this.addonItemStatus,
      this.variationTotal,
      this.variationTotalFlatPrice,
      this.variationTotalConvertPrice,
      this.variationTotalCurrencyPrice,
      this.total,
      this.totalFlatPrice,
      this.totalConvertPrice,
      this.totalCurrencyPrice,
      this.variationNames,
      this.thumb,
      this.cover,
      this.preview,
      this.caution,
      this.offer});

  int? id;
  int? itemId;
  int? itemAddonId;
  String? itemName;
  String? addonItemName;
  String? addonItemPrice;
  String? addonItemFlatPrice;
  double? addonItemConvertPrice;
  String? addonItemCurrencyPrice;
  int? addonItemStatus;
  int? variationTotal;
  String? variationTotalFlatPrice;
  int? variationTotalConvertPrice;
  String? variationTotalCurrencyPrice;
  double? total;
  String? totalFlatPrice;
  double? totalConvertPrice;
  String? totalCurrencyPrice;
  List<VariationName>? variationNames;
  String? thumb;
  String? cover;
  String? preview;
  dynamic caution;
  List<Offer>? offer;

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        id: json["id"],
        itemId: json["item_id"],
        itemAddonId: json["item_addon_id"],
        itemName: json["item_name"],
        addonItemName: json["addon_item_name"],
        addonItemPrice: json["addon_item_price"],
        addonItemFlatPrice: json["addon_item_flat_price"],
        addonItemConvertPrice: json["addon_item_convert_price"]?.toDouble(),
        addonItemCurrencyPrice: json["addon_item_currency_price"],
        addonItemStatus: json["addon_item_status"],
        variationTotal: json["variation_total"],
        variationTotalFlatPrice: json["variation_total_flat_price"],
        variationTotalConvertPrice: json["variation_total_convert_price"],
        variationTotalCurrencyPrice: json["variation_total_currency_price"],
        total: json["total"]?.toDouble(),
        totalFlatPrice: json["total_flat_price"],
        totalConvertPrice: json["total_convert_price"]?.toDouble(),
        totalCurrencyPrice: json["total_currency_price"],
        variationNames: json["variation_names"] == null
            ? []
            : List<VariationName>.from(
                json["variation_names"]!.map((x) => VariationName.fromJson(x))),
        thumb: json["thumb"],
        cover: json["cover"],
        preview: json["preview"],
        caution: json["caution"],
        offer: json["offer"] == null
            ? []
            : List<Offer>.from(json["offer"]!.map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "item_addon_id": itemAddonId,
        "item_name": itemName,
        "addon_item_name": addonItemName,
        "addon_item_price": addonItemPrice,
        "addon_item_flat_price": addonItemFlatPrice,
        "addon_item_convert_price": addonItemConvertPrice,
        "addon_item_currency_price": addonItemCurrencyPrice,
        "addon_item_status": addonItemStatus,
        "variation_total": variationTotal,
        "variation_total_flat_price": variationTotalFlatPrice,
        "variation_total_convert_price": variationTotalConvertPrice,
        "variation_total_currency_price": variationTotalCurrencyPrice,
        "total": total,
        "total_flat_price": totalFlatPrice,
        "total_convert_price": totalConvertPrice,
        "total_currency_price": totalCurrencyPrice,
        "variation_names": variationNames == null
            ? []
            : List<dynamic>.from(variationNames!.map((x) => x.toJson())),
        "thumb": thumb,
        "cover": cover,
        "preview": preview,
        "caution": caution,
        "offer": offer == null
            ? []
            : List<dynamic>.from(offer!.map((x) => x.toJson())),
      };
}

class VariationName {
  int? id;
  String? name;
  String? attributeName;

  VariationName({
    this.id,
    this.name,
    this.attributeName,
  });

  factory VariationName.fromJson(Map<String, dynamic> json) => VariationName(
        id: json["id"],
        name: json["name"],
        attributeName: json["attribute_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "attribute_name": attributeName,
      };
}

class Extra {
  Extra({
    this.id,
    this.itemId,
    this.name,
    this.price,
    this.currencyPrice,
    this.flatPrice,
    this.convertPrice,
    this.status,
    this.item,
  });

  int? id;
  int? itemId;
  String? name;
  String? price;
  String? currencyPrice;
  String? flatPrice;
  dynamic convertPrice;
  int? status;
  String? item;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        itemId: json["item_id"],
        name: json["name"],
        price: json["price"],
        currencyPrice: json["currency_price"],
        flatPrice: json["flat_price"],
        convertPrice: json["convert_price"],
        status: json["status"],
        item: json["item"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "name": name,
        "price": price,
        "currency_price": currencyPrice,
        "flat_price": flatPrice,
        "convert_price": convertPrice,
        "status": status,
        "item": item,
      };
}

class ItemAttribute {
  ItemAttribute({
    this.id,
    this.name,
    this.status,
  });

  int? id;
  String? name;
  int? status;

  factory ItemAttribute.fromJson(Map<String, dynamic> json) => ItemAttribute(
        id: json["id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
      };
}

class Offer {
  Offer({
    this.id,
    this.name,
    this.amount,
    this.flatPrice,
    this.convertPrice,
    this.currencyPrice,
  });

  int? id;
  String? name;
  String? amount;
  String? flatPrice;
  double? convertPrice;
  String? currencyPrice;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        flatPrice: json["flat_price"],
        convertPrice: json["convert_price"]?.toDouble(),
        currencyPrice: json["currency_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "flat_price": flatPrice,
        "convert_price": convertPrice,
        "currency_price": currencyPrice,
      };
}

class Variation {
  Variation({
    this.id,
    this.itemId,
    this.itemAttributeId,
    this.name,
    this.price,
    this.caution,
    this.status,
    this.creatorType,
    this.creatorId,
    this.editorType,
    this.editorId,
    this.createdAt,
    this.updatedAt,
    this.convertPrice,
    this.currencyPrice,
    this.flatPrice,
    this.itemAttribute,
  });

  int? id;
  int? itemId;
  int? itemAttributeId;
  String? name;
  String? price;
  dynamic caution;
  int? status;
  dynamic creatorType;
  dynamic creatorId;
  dynamic editorType;
  dynamic editorId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? convertPrice;
  String? currencyPrice;
  String? flatPrice;
  ItemAttributeClass? itemAttribute;

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        id: json["id"],
        itemId: json["item_id"],
        itemAttributeId: json["item_attribute_id"],
        name: json["name"],
        price: json["price"],
        caution: json["caution"],
        status: json["status"],
        creatorType: json["creator_type"],
        creatorId: json["creator_id"],
        editorType: json["editor_type"],
        editorId: json["editor_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        convertPrice: json["convert_price"],
        currencyPrice: json["currency_price"],
        flatPrice: json["flat_price"],
        itemAttribute: json["item_attribute"] == null
            ? null
            : ItemAttributeClass.fromJson(json["item_attribute"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "item_attribute_id": itemAttributeId,
        "name": name,
        "price": price,
        "caution": caution,
        "status": status,
        "creator_type": creatorType,
        "creator_id": creatorId,
        "editor_type": editorType,
        "editor_id": editorId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "convert_price": convertPrice,
        "currency_price": currencyPrice,
        "flat_price": flatPrice,
        "item_attribute": itemAttribute?.toJson(),
      };
}

class ItemAttributeClass {
  ItemAttributeClass({
    this.id,
    this.name,
    this.status,
    this.creatorType,
    this.creatorId,
    this.editorType,
    this.editorId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? status;
  dynamic creatorType;
  dynamic creatorId;
  dynamic editorType;
  dynamic editorId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ItemAttributeClass.fromJson(Map<String, dynamic> json) =>
      ItemAttributeClass(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        creatorType: json["creator_type"],
        creatorId: json["creator_id"],
        editorType: json["editor_type"],
        editorId: json["editor_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "creator_type": creatorType,
        "creator_id": creatorId,
        "editor_type": editorType,
        "editor_id": editorId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
