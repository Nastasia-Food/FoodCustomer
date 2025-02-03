import 'dart:convert';

AddressListModel addressListModelFromJson(String str) =>
    AddressListModel.fromJson(json.decode(str));

String addressListModelToJson(AddressListModel data) =>
    json.encode(data.toJson());

class AddressListModel {
  AddressListModel({
    this.data,
  });

  List<AddressListData>? data;

  factory AddressListModel.fromJson(Map<String, dynamic> json) =>
      AddressListModel(
        data: json["data"] == null
            ? null
            : List<AddressListData>.from(
                json["data"].map((x) => AddressListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AddressListData {
  AddressListData({
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

  factory AddressListData.fromJson(Map<String, dynamic> json) =>
      AddressListData(
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
