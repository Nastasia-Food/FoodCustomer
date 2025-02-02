// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:convert';

import 'package:get/get.dart';

import '../../../../util/api-list.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/item_model.dart';
import '../../../data/model/response/offer_item_model.dart';
import '../../../data/model/response/offer_model.dart';
import '../../../data/repository/offer_repo.dart';
import '../views/offer_item_view.dart';

class OfferController extends GetxController {
  List<OfferData> offerDataList = <OfferData>[];
  static Server server = Server();
  bool lodear = false;
  bool offerItemlodear = false;
  OfferItemModel offerItemModel = OfferItemModel();
  static OfferItemData offerItemData = OfferItemData();
  List<ItemData> offeritemList = <ItemData>[];

  @override
  void onInit() {
    getOfferList();
    super.onInit();
  }

  getOfferList() async {
    lodear = true;
    update();
    var offerData = await OfferRepo.getOffer();
    if (offerData != null) {
      lodear = false;
      offerDataList = offerData.data!;
      update();
    }
    lodear = false;
    update();
  }

  getOfferItemList(String slug) async {
    offerItemlodear = true;
    update();
    await server
        .getRequestWithoutToken(
      endPoint: APIList.offerItems! + slug.toString(),
    )
        .then((response) {
      if (response != null && response.statusCode == 200) {
        offerItemlodear = false;
        update();
        final jsonResponse = json.decode(response.body);
        offerItemModel = OfferItemModel.fromJson(jsonResponse);
        offeritemList = offerItemModel.data!.items!;
        Get.to(OfferItemView());
        update();
        return offerItemModel.data!.items;
      } else {
        offerItemlodear = false;
        update();
      }
    });
  }
}
