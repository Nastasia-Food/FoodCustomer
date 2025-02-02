// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  OrdersModel({
    this.data,
  });

  List<OrdersData>? data;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        data: json["data"] == null
            ? []
            : List<OrdersData>.from(
                json["data"]!.map((x) => OrdersData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OrdersData {
  OrdersData({
    this.id,
    this.orderSerialNo,
    this.userId,
    this.branchId,
    this.branchName,
    this.orderItems,
    this.totalCurrencyPrice,
    this.totalAmountPrice,
    this.discountCurrencyPrice,
    this.deliveryChargeCurrencyPrice,
    this.paymentMethod,
    this.paymentStatus,
    this.preparationTime,
    this.orderType,
    this.orderDatetime,
    this.status,
    this.isAdvanceOrder,
    this.statusName,
    this.customer,
    this.transaction,
  });

  int? id;
  String? orderSerialNo;
  int? userId;
  int? branchId;
  String? branchName;
  int? orderItems;
  String? totalCurrencyPrice;
  String? totalAmountPrice;
  String? discountCurrencyPrice;
  String? deliveryChargeCurrencyPrice;
  int? paymentMethod;
  int? paymentStatus;
  int? preparationTime;
  int? orderType;
  String? orderDatetime;
  int? status;
  int? isAdvanceOrder;
  String? statusName;
  Customer? customer;
  dynamic transaction;

  factory OrdersData.fromJson(Map<String, dynamic> json) => OrdersData(
        id: json["id"],
        orderSerialNo: json["order_serial_no"],
        userId: json["user_id"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        orderItems: json["order_items"],
        totalCurrencyPrice: json["total_currency_price"],
        totalAmountPrice: json["total_amount_price"],
        discountCurrencyPrice: json["discount_currency_price"],
        deliveryChargeCurrencyPrice: json["delivery_charge_currency_price"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        preparationTime: json["preparation_time"],
        orderType: json["order_type"],
        orderDatetime: json["order_datetime"],
        status: json["status"],
        isAdvanceOrder: json["is_advance_order"],
        statusName: json["status_name"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        transaction: json["transaction"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_serial_no": orderSerialNo,
        "user_id": userId,
        "branch_id": branchId,
        "branch_name": branchName,
        "order_items": orderItems,
        "total_currency_price": totalCurrencyPrice,
        "total_amount_price": totalAmountPrice,
        "discount_currency_price": discountCurrencyPrice,
        "delivery_charge_currency_price": deliveryChargeCurrencyPrice,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "preparation_time": preparationTime,
        "order_type": orderType,
        "order_datetime": orderDatetime,
        "status": status,
        "is_advance_order": isAdvanceOrder,
        "status_name": statusName,
        "customer": customer?.toJson(),
        "transaction": transaction,
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.username,
    this.balance,
    this.image,
    this.roleId,
    this.countryCode,
    this.order,
  });

  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? username;
  String? balance;
  String? image;
  int? roleId;
  String? countryCode;
  int? order;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        username: json["username"],
        balance: json["balance"],
        image: json["image"],
        roleId: json["role_id"],
        countryCode: json["country_code"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "username": username,
        "balance": balance,
        "image": image,
        "role_id": roleId,
        "country_code": countryCode,
        "order": order,
      };
}
