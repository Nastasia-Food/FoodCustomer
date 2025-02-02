// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    this.data,
  });

  OrderDetailsData? data;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        data: json["data"] == null
            ? null
            : OrderDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class OrderDetailsData {
  OrderDetailsData({
    this.id,
    this.orderSerialNo,
    this.token,
    this.subtotalCurrencyPrice,
    this.discountCurrencyPrice,
    this.deliveryChargeCurrencyPrice,
    this.totalCurrencyPrice,
    this.orderType,
    this.orderDatetime,
    this.orderDate,
    this.orderTime,
    this.deliveryDate,
    this.deliveryTime,
    this.paymentMethod,
    this.paymentStatus,
    this.isAdvanceOrder,
    this.preparationTime,
    this.status,
    this.statusName,
    this.reason,
    this.user,
    this.orderAddress,
    this.branch,
    this.deliveryBoy,
    this.coupon,
    this.transaction,
    this.orderItems,
  });

  int? id;
  String? orderSerialNo;
  dynamic token;
  String? subtotalCurrencyPrice;
  String? discountCurrencyPrice;
  String? deliveryChargeCurrencyPrice;
  String? totalCurrencyPrice;
  int? orderType;
  String? orderDatetime;
  String? orderDate;
  String? orderTime;
  String? deliveryDate;
  String? deliveryTime;
  int? paymentMethod;
  int? paymentStatus;
  int? isAdvanceOrder;
  int? preparationTime;
  int? status;
  String? statusName;
  dynamic reason;
  User? user;
  OrderAddress? orderAddress;
  Branch? branch;
  dynamic deliveryBoy;
  dynamic coupon;
  Transaction? transaction;
  List<OrderItem>? orderItems;

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) =>
      OrderDetailsData(
        id: json["id"],
        orderSerialNo: json["order_serial_no"],
        token: json["token"],
        subtotalCurrencyPrice: json["subtotal_currency_price"],
        discountCurrencyPrice: json["discount_currency_price"],
        deliveryChargeCurrencyPrice: json["delivery_charge_currency_price"],
        totalCurrencyPrice: json["total_currency_price"],
        orderType: json["order_type"],
        orderDatetime: json["order_datetime"],
        orderDate: json["order_date"],
        orderTime: json["order_time"],
        deliveryDate: json["delivery_date"],
        deliveryTime: json["delivery_time"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        isAdvanceOrder: json["is_advance_order"],
        preparationTime: json["preparation_time"],
        status: json["status"],
        statusName: json["status_name"],
        reason: json["reason"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        orderAddress: json["order_address"] == null
            ? null
            : OrderAddress.fromJson(json["order_address"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        deliveryBoy: json["delivery_boy"],
        coupon: json["coupon"],
        transaction: json["transaction"] == null
            ? null
            : Transaction.fromJson(json["transaction"]),
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_serial_no": orderSerialNo,
        "token": token,
        "subtotal_currency_price": subtotalCurrencyPrice,
        "discount_currency_price": discountCurrencyPrice,
        "delivery_charge_currency_price": deliveryChargeCurrencyPrice,
        "total_currency_price": totalCurrencyPrice,
        "order_type": orderType,
        "order_datetime": orderDatetime,
        "order_date": orderDate,
        "order_time": orderTime,
        "delivery_date": deliveryDate,
        "delivery_time": deliveryTime,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "is_advance_order": isAdvanceOrder,
        "preparation_time": preparationTime,
        "status": status,
        "status_name": statusName,
        "reason": reason,
        "user": user?.toJson(),
        "order_address": orderAddress?.toJson(),
        "branch": branch?.toJson(),
        "delivery_boy": deliveryBoy,
        "coupon": coupon,
        "transaction": transaction?.toJson(),
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}

class Branch {
  Branch({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.zipCode,
    this.address,
    this.status,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  String? latitude;
  String? longitude;
  String? city;
  String? state;
  String? zipCode;
  String? address;
  int? status;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
        address: json["address"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "address": address,
        "status": status,
      };
}

class Coupon {
  Coupon({
    this.id,
    this.name,
    this.description,
    this.code,
    this.discount,
    this.flatDiscount,
    this.convertDiscount,
    this.currencyDiscount,
    this.discountType,
    this.convertStartDate,
    this.convertEndDate,
    this.startDate,
    this.endDate,
    this.minimumOrder,
    this.minimumOrderFlatAmount,
    this.minimumOrderConvertAmount,
    this.minimumOrderCurrencyAmount,
    this.maxmiumDiscount,
    this.maxmiumFlatDiscount,
    this.maxmiumConvertDiscount,
    this.maxmiumCurrencyDiscount,
    this.limitPerUser,
    this.image,
  });

  int? id;
  dynamic name;
  String? description;
  dynamic code;
  String? discount;
  String? flatDiscount;
  int? convertDiscount;
  String? currencyDiscount;
  int? discountType;
  String? convertStartDate;
  String? convertEndDate;
  String? startDate;
  String? endDate;
  int? minimumOrder;
  String? minimumOrderFlatAmount;
  int? minimumOrderConvertAmount;
  String? minimumOrderCurrencyAmount;
  int? maxmiumDiscount;
  String? maxmiumFlatDiscount;
  int? maxmiumConvertDiscount;
  String? maxmiumCurrencyDiscount;
  int? limitPerUser;
  dynamic image;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        code: json["code"],
        discount: json["discount"],
        flatDiscount: json["flat_discount"],
        convertDiscount: json["convert_discount"],
        currencyDiscount: json["currency_discount"],
        discountType: json["discount_type"],
        convertStartDate: json["convert_start_date"],
        convertEndDate: json["convert_end_date"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        minimumOrder: json["minimum_order"],
        minimumOrderFlatAmount: json["minimum_order_flat_amount"],
        minimumOrderConvertAmount: json["minimum_order_convert_amount"],
        minimumOrderCurrencyAmount: json["minimum_order_currency_amount"],
        maxmiumDiscount: json["maxmium_discount"],
        maxmiumFlatDiscount: json["maxmium_flat_discount"],
        maxmiumConvertDiscount: json["maxmium_convert_discount"],
        maxmiumCurrencyDiscount: json["maxmium_currency_discount"],
        limitPerUser: json["limit_per_user"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "code": code,
        "discount": discount,
        "flat_discount": flatDiscount,
        "convert_discount": convertDiscount,
        "currency_discount": currencyDiscount,
        "discount_type": discountType,
        "convert_start_date": convertStartDate,
        "convert_end_date": convertEndDate,
        "start_date": startDate,
        "end_date": endDate,
        "minimum_order": minimumOrder,
        "minimum_order_flat_amount": minimumOrderFlatAmount,
        "minimum_order_convert_amount": minimumOrderConvertAmount,
        "minimum_order_currency_amount": minimumOrderCurrencyAmount,
        "maxmium_discount": maxmiumDiscount,
        "maxmium_flat_discount": maxmiumFlatDiscount,
        "maxmium_convert_discount": maxmiumConvertDiscount,
        "maxmium_currency_discount": maxmiumCurrencyDiscount,
        "limit_per_user": limitPerUser,
        "image": image,
      };
}

class OrderAddress {
  OrderAddress({
    this.id,
    this.userId,
    this.label,
    this.address,
    this.apartment,
    this.latitude,
    this.longitude,
  });

  int? id;
  int? userId;
  String? label;
  String? address;
  String? apartment;
  String? latitude;
  String? longitude;

  factory OrderAddress.fromJson(Map<String, dynamic> json) => OrderAddress(
        id: json["id"],
        userId: json["user_id"],
        label: json["label"],
        address: json["address"],
        apartment: json["apartment"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "label": label,
        "address": address,
        "apartment": apartment,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class OrderItem {
  OrderItem({
    this.id,
    this.orderId,
    this.branchId,
    this.itemId,
    this.itemName,
    this.itemImage,
    this.quantity,
    this.discount,
    this.price,
    this.itemVariations,
    this.itemExtras,
    this.itemVariationCurrencyTotal,
    this.itemExtraCurrencyTotal,
    this.totalConvertPrice,
    this.totalCurrencyPrice,
    this.instruction,
  });

  int? id;
  int? orderId;
  int? branchId;
  int? itemId;
  String? itemName;
  String? itemImage;
  int? quantity;
  String? discount;
  String? price;
  List<ItemVariation>? itemVariations;
  List<ItemExtra>? itemExtras;
  String? itemVariationCurrencyTotal;
  String? itemExtraCurrencyTotal;
  dynamic totalConvertPrice;
  String? totalCurrencyPrice;
  dynamic instruction;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        branchId: json["branch_id"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemImage: json["item_image"],
        quantity: json["quantity"],
        discount: json["discount"],
        price: json["price"],
        itemVariations: json["item_variations"] == null
            ? []
            : List<ItemVariation>.from(
                json["item_variations"]!.map((x) => ItemVariation.fromJson(x))),
        itemExtras: json["item_extras"] == null
            ? []
            : List<ItemExtra>.from(
                json["item_extras"]!.map((x) => ItemExtra.fromJson(x))),
        itemVariationCurrencyTotal: json["item_variation_currency_total"],
        itemExtraCurrencyTotal: json["item_extra_currency_total"],
        totalConvertPrice: json["total_convert_price"],
        totalCurrencyPrice: json["total_currency_price"],
        instruction: json["instruction"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "branch_id": branchId,
        "item_id": itemId,
        "item_name": itemName,
        "item_image": itemImage,
        "quantity": quantity,
        "discount": discount,
        "price": price,
        "item_variations": itemVariations == null
            ? []
            : List<dynamic>.from(itemVariations!.map((x) => x.toJson())),
        "item_extras": itemExtras == null
            ? []
            : List<dynamic>.from(itemExtras!.map((x) => x.toJson())),
        "item_variation_currency_total": itemVariationCurrencyTotal,
        "item_extra_currency_total": itemExtraCurrencyTotal,
        "total_convert_price": totalConvertPrice,
        "total_currency_price": totalCurrencyPrice,
        "instruction": instruction,
      };
}

class ItemExtra {
  ItemExtra({
    this.id,
    this.itemId,
    this.name,
  });

  int? id;
  int? itemId;
  String? name;

  factory ItemExtra.fromJson(Map<String, dynamic> json) => ItemExtra(
        id: json["id"],
        itemId: json["item_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "name": name,
      };
}

class ItemVariation {
  ItemVariation({
    this.id,
    this.itemId,
    this.itemAttributeId,
    this.variationName,
    this.name,
  });

  int? id;
  dynamic itemId;
  dynamic itemAttributeId;
  String? variationName;
  String? name;

  factory ItemVariation.fromJson(Map<String, dynamic> json) => ItemVariation(
        id: json["id"],
        itemId: json["item_id"],
        itemAttributeId: json["item_attribute_id"],
        variationName: json["variation_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "item_attribute_id": itemAttributeId,
        "variation_name": variationName,
        "name": name,
      };
}

class Transaction {
  int? id;
  int? orderId;
  String? orderSerialNo;
  String? transactionNo;
  String? amount;
  String? paymentMethod;
  String? type;
  String? sign;
  String? date;

  Transaction({
    this.id,
    this.orderId,
    this.orderSerialNo,
    this.transactionNo,
    this.amount,
    this.paymentMethod,
    this.type,
    this.sign,
    this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        orderId: json["order_id"],
        orderSerialNo: json["order_serial_no"],
        transactionNo: json["transaction_no"],
        amount: json["amount"],
        paymentMethod: json["payment_method"],
        type: json["type"],
        sign: json["sign"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "order_serial_no": orderSerialNo,
        "transaction_no": transactionNo,
        "amount": amount,
        "payment_method": paymentMethod,
        "type": type,
        "sign": sign,
        "date": date,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.username,
    this.order,
    this.createDate,
    this.updateDate,
    this.image,
  });

  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? username;
  int? order;
  String? createDate;
  String? updateDate;
  String? image;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        username: json["username"],
        order: json["order"],
        createDate: json["create_date"],
        updateDate: json["update_date"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "username": username,
        "order": order,
        "create_date": createDate,
        "update_date": updateDate,
        "image": image,
      };
}
