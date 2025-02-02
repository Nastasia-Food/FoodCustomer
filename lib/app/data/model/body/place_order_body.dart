// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderBody placeOrderModelFromJson(String str) =>
    PlaceOrderBody.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderBody data) => json.encode(data.toJson());

class PlaceOrderBody {
  PlaceOrderBody({
    this.branchId,
    this.orderType,
    this.isAdvanceOrder,
    this.deliveryCharge,
    this.distance,
    this.addressId,
    this.deliveryTime,
    this.subtotal,
    this.total,
    this.couponId,
    this.discount,
    this.source,
    this.items,
  });

  int? branchId;
  int? orderType;
  int? isAdvanceOrder;
  double? deliveryCharge;
  double? distance;
  int? addressId;
  String? deliveryTime;
  double? subtotal;
  double? total;
  int? couponId;
  double? discount;
  int? source;
  List<Cart>? items;

  factory PlaceOrderBody.fromJson(Map<String, dynamic> json) => PlaceOrderBody(
        branchId: json["branch_id"],
        orderType: json["order_type"],
        isAdvanceOrder: json["is_advance_order"],
        deliveryCharge: json["delivery_charge"],
        distance: json["distance"],
        addressId: json["address_id"],
        deliveryTime: json["delivery_time"],
        subtotal: json["subtotal"],
        total: json["total"],
        couponId: json["coupon_id"],
        discount: json["discount"],
        source: json["source"],
        items: json["items"] == null
            ? []
            : List<Cart>.from(json["items"]!.map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "branch_id": branchId,
        "order_type": orderType,
        "is_advance_order": isAdvanceOrder,
        "delivery_charge": deliveryCharge,
        "distance": distance,
        "address_id": addressId,
        "delivery_time": deliveryTime,
        "subtotal": subtotal,
        "total": total,
        "coupon_id": couponId,
        "discount": discount,
        "source": source,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Cart {
  Cart({
    this.itemId,
    this.itemPrice,
    this.itemName,
    this.itemImage,
    this.branchId,
    this.instruction,
    this.quantity,
    this.discount,
    this.totalPrice,
    this.itemVariationTotal,
    this.itemExtraTotal,
    this.itemVariations,
    this.itemExtras,
  });

  int? itemId;
  double? itemPrice;
  String? itemName;
  String? itemImage;
  int? branchId;
  String? instruction;
  int? quantity;
  double? discount;
  double? totalPrice;
  double? itemVariationTotal;
  double? itemExtraTotal;
  List<Variations>? itemVariations;
  List<Extras>? itemExtras;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        itemId: json["item_id"],
        itemPrice: json["item_price"]?.toDouble(),
        branchId: json["branch_id"],
        itemName: json["item_name"],
        itemImage: json["item_image"],
        instruction: json["instruction"],
        quantity: json["quantity"],
        discount: json["discount"],
        totalPrice: json["total_price"],
        itemVariationTotal: json["item_variation_total"],
        itemExtraTotal: json["item_extra_total"],
        itemVariations: json["item_variations"] == null
            ? []
            : List<Variations>.from(
                json["item_variations"]!.map((x) => Variations.fromJson(x))),
        itemExtras: json["item_extras"] == null
            ? []
            : List<Extras>.from(
                json["item_extras"]!.map((x) => Extras.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_price": itemPrice,
        "branch_id": branchId,
        "instruction": instruction,
        "quantity": quantity,
        "discount": discount,
        "total_price": (totalPrice! * quantity!),
        "item_variation_total": itemVariationTotal,
        "item_extra_total": itemExtraTotal,
        "item_variations": itemVariations == null
            ? []
            : List<dynamic>.from(itemVariations!.map((x) => x.toJson())),
        "item_extras": itemExtras == null
            ? []
            : List<dynamic>.from(itemExtras!.map((x) => x.toJson())),
      };
}

class Variations {
  Variations({
    this.id,
    this.itemId,
    this.itemAttributeId,
    this.variationName,
    this.name,
    this.price,
  });

  int? id;
  int? itemId;
  int? itemAttributeId;
  String? variationName;
  String? name;
  double? price;

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
        id: json["id"],
        itemId: json["item_id"],
        itemAttributeId: json["item_attribute_id"],
        variationName: json["variation_name"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "item_attribute_id": itemAttributeId,
        "variation_name": variationName,
        "name": name,
        "price": price,
      };
}

class Extras {
  Extras({
    this.id,
    this.itemId,
    this.name,
    this.price,
  });

  int? id;
  int? itemId;
  String? name;
  double? price;

  factory Extras.fromJson(Map<String, dynamic> json) => Extras(
        id: json["id"],
        itemId: json["item_id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "name": name,
        "price": price,
      };
}

class Addons {
  Addons(
      {this.id,
      this.itemId,
      this.quantity,
      this.name,
      this.image,
      this.price,
      this.totalPrice,
      this.itemVariationTotal,
      this.itemExtraTotal,
      this.totalConvertPrice});

  int? id;
  int? itemId;
  int? quantity;
  String? name;
  String? image;
  double? price;
  double? totalPrice;
  double? itemVariationTotal;
  double? itemExtraTotal;
  double? totalConvertPrice;

  factory Addons.fromJson(Map<String, dynamic> json) => Addons(
        id: json["id"],
        itemId: json["item_id"],
        quantity: json["quantity"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        itemVariationTotal: json["item_variation_total"],
        itemExtraTotal: json["item_extra_total"],
        totalPrice: json["total_price"],
        totalConvertPrice: json["total_convert_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "quantity": quantity,
        "name": name,
        "image": image,
        "price": price,
        "total_price": totalPrice,
        "item_extra_total": itemExtraTotal,
        "item_variation_total": itemVariationTotal,
        "total_convert_price": totalConvertPrice,
      };
}
