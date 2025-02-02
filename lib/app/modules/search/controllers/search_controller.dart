import 'package:get/get.dart';

import '../../../data/model/response/item_model.dart';
import '../../home/controllers/home_controller.dart';

class SearchController extends GetxController {
  HomeController homeController = Get.put(HomeController());
  List<ItemData> searchDataList = <ItemData>[];
  List<ItemData> foundItem = [];
  List<ItemData> results = [];

  bool itemLoader = false;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() {
    itemLoader = true;
    update();
    Get.find<HomeController>().getItemDataList();
    update();
    searchDataList = homeController.itemDataList;
    results = searchDataList;
    itemLoader = false;
    update();
  }

  filterItem(String itemName) async {
    itemLoader = true;
    update();
    getData();
    if (itemName.isEmpty) {
      results = searchDataList;
      update();
    } else {
      results = searchDataList
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(itemName.toLowerCase()))
          .toList();
    }
    foundItem = results;
    itemLoader = false;
    update();
  }
}
