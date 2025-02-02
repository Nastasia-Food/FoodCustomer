// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/offer_model.dart';

class OfferRepo {
  static Server server = Server();
  static OfferModel offerModelData = OfferModel();

  static Future<OfferModel?> getOffer() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.offer! + "?status=5",
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          offerModelData = OfferModel.fromJson(jsonResponse);
          return offerModelData;
        }
      });
      return offerModelData;
    } catch (e) {
      return null;
    }
  }
}
