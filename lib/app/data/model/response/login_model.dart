// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.message,
    this.token,
    this.branchId,
    this.user,
  });

  String? message;
  String? token;
  int? branchId;
  User? user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        token: json["token"],
        branchId: json["branch_id"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "branch_id": branchId,
        "user": user!.toJson(),
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
        "create_date": createDate,
        "update_date": updateDate,
        "image": image,
      };
}
