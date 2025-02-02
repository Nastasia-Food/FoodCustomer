// To parse this JSON data, do
//
//     final pageModel = pageModelFromJson(jsonString);

import 'dart:convert';

PageModel pageModelFromJson(String str) => PageModel.fromJson(json.decode(str));

String pageModelToJson(PageModel data) => json.encode(data.toJson());

class PageModel {
  List<PageData>? data;

  PageModel({
    this.data,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
        data: json["data"] == null
            ? []
            : List<PageData>.from(
                json["data"]!.map((x) => PageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PageData {
  int? id;
  String? title;
  String? slug;
  String? description;
  int? menuSectionId;
  int? templateId;
  int? status;
  String? image;

  PageData({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.menuSectionId,
    this.templateId,
    this.status,
    this.image,
  });

  factory PageData.fromJson(Map<String, dynamic> json) => PageData(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        menuSectionId: json["menu_section_id"],
        templateId: json["template_id"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "description": description,
        "menu_section_id": menuSectionId,
        "template_id": templateId,
        "status": status,
        "image": image,
      };
}
