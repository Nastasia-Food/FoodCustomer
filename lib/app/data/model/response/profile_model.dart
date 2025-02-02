// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileData? data;

  ProfileModel({
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ProfileData {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? username;
  String? balance;
  String? currencyBalance;
  String? image;
  int? roleId;
  String? countryCode;
  int? order;
  String? createDate;
  String? updateDate;

  ProfileData({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.username,
    this.balance,
    this.currencyBalance,
    this.image,
    this.roleId,
    this.countryCode,
    this.order,
    this.createDate,
    this.updateDate,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        username: json["username"],
        balance: json["balance"],
        currencyBalance: json["currency_balance"],
        image: json["image"],
        roleId: json["role_id"],
        countryCode: json["country_code"],
        order: json["order"],
        createDate: json["create_date"],
        updateDate: json["update_date"],
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
        "currency_balance": currencyBalance,
        "image": image,
        "role_id": roleId,
        "country_code": countryCode,
        "order": order,
        "create_date": createDate,
        "update_date": updateDate,
      };
}
