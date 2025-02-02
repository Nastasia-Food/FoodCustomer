// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/item_model.dart';

class FeaturedItemRepo {
  static Server server = Server();
  static ItemModel featuredItem = ItemModel();

  static Future<ItemModel?> getFeaturedItem() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.featuredItems!,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          featuredItem = ItemModel.fromJson(jsonResponse);
          return featuredItem;
        }
      });
      return featuredItem;
    } catch (e) {
      return null;
    }
  }
}
