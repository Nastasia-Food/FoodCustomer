// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

BranchModel branchModelFromJson(String str) =>
    BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
  BranchModel({
    this.data,
  });

  List<BranchData>? data;

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        data: json["data"] == null
            ? []
            : List<BranchData>.from(
                json["data"]!.map((x) => BranchData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BranchData {
  BranchData({
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

  factory BranchData.fromJson(Map<String, dynamic> json) => BranchData(
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
