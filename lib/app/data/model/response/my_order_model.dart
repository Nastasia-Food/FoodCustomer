// To parse this JSON data, do
//
//     final myOrder = myOrderFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison

import 'dart:convert';

MyOrderModel myOrderFromJson(String str) =>
    MyOrderModel.fromJson(json.decode(str));

String myOrderToJson(MyOrderModel data) => json.encode(data.toJson());

class MyOrderModel {
  MyOrderModel({
    this.data,
  });

  List<MyOrderData>? data;

  factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
        data: json["data"] == null
            ? null
            : List<MyOrderData>.from(
                json["data"].map((x) => MyOrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MyOrderData {
  MyOrderData({
    this.id,
    this.orderSerialNo,
    this.userId,
    this.branchId,
    this.totalQuantity,
    this.subtotal,
    this.discount,
    this.deliveryCharge,
    this.total,
    this.orderType,
    this.orderDatetime,
    this.convertOrderDatetime,
    this.isAdvanceOrder,
    this.address,
    this.paymentMethod,
    this.paymentStatus,
    this.status,
    this.statusName,
    this.deliveryBoyId,
    this.reson,
    this.lat,
    this.long,
  });

  int? id;
  int? orderSerialNo;
  int? userId;
  int? branchId;
  int? totalQuantity;
  double? subtotal;
  double? discount;
  double? deliveryCharge;
  double? total;
  int? orderType;
  DateTime? orderDatetime;
  String? convertOrderDatetime;
  int? isAdvanceOrder;
  String? address;
  int? paymentMethod;
  int? paymentStatus;
  int? status;
  String? statusName;
  int? deliveryBoyId;
  String? reson;
  String? lat;
  String? long;

  factory MyOrderData.fromJson(Map<String, dynamic> json) => MyOrderData(
        id: json["id"] == null ? null : json["id"],
        orderSerialNo: json["order_serial_no"].toString() == null
            ? null
            : json["order_serial_no"],
        userId: json["user_id"] == null ? null : json["user_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        totalQuantity:
            json["total_quantity"] == null ? null : json["total_quantity"],
        subtotal: json["subtotal"] == null ? null : json["subtotal"],
        discount: json["discount"] == null ? null : json["discount"],
        deliveryCharge:
            json["delivery_charge"] == null ? null : json["delivery_charge"],
        total: json["total"] == null ? null : json["total"],
        orderType: json["order_type"] == null ? null : json["order_type"],
        orderDatetime: json["order_datetime"] == null
            ? null
            : DateTime.parse(json["order_datetime"]),
        convertOrderDatetime: json["convert_order_datetime"] == null
            ? null
            : json["convert_order_datetime"],
        isAdvanceOrder:
            json["is_advance_order"] == null ? null : json["is_advance_order"],
        address: json["address"] == null ? null : json["address"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        status: json["status"] == null ? null : json["status"],
        statusName: json["status_name"] == null ? null : json["status_name"],
        deliveryBoyId:
            json["delivery_boy_id"] == null ? null : json["delivery_boy_id"],
        reson: json["reson"] == null ? null : json["reson"],
        lat: json["lat"] == null ? null : json["lat"],
        long: json["long"] == null ? null : json["long"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "order_serial_no": orderSerialNo == null ? null : orderSerialNo,
        "user_id": userId == null ? null : userId,
        "branch_id": branchId == null ? null : branchId,
        "total_quantity": totalQuantity == null ? null : totalQuantity,
        "subtotal": subtotal == null ? null : subtotal,
        "discount": discount == null ? null : discount,
        "delivery_charge": deliveryCharge == null ? null : deliveryCharge,
        "total": total == null ? null : total,
        "order_type": orderType == null ? null : orderType,
        "order_datetime": orderDatetime?.toIso8601String(),
        "convert_order_datetime":
            convertOrderDatetime == null ? null : convertOrderDatetime,
        "is_advance_order": isAdvanceOrder == null ? null : isAdvanceOrder,
        "address": address == null ? null : address,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "status": status == null ? null : status,
        "status_name": statusName == null ? null : statusName,
        "delivery_boy_id": deliveryBoyId == null ? null : deliveryBoyId,
        "reson": reson == null ? null : reson,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
      };
}
