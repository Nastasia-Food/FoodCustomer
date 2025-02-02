// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:get/get.dart';
import '../../../../util/api-list.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/category_model.dart';
import '../../../data/model/response/category_wise_item_model.dart';
import '../../../data/model/response/item_model.dart';
import '../../../data/repository/category_repo.dart';
import '../../../data/repository/item_repo.dart';

class MenuuController extends GetxController {
  List<CategoryData> categoryDataList = <CategoryData>[];
  List<ItemData> categoryItemDataList = <ItemData>[];
  List<ItemData> categoryItemVgDataList = <ItemData>[];

  int currentIndex = 0;
  int selectedCategoryIndex = 0;
  int vegNonVegActive = 0;
  int vegNonVegActiveList = 0;
  bool fromHome = true;
  String? selectedBranch;
  bool menuLoader = false;
  bool itemLoader = false;
  bool menuItemLoader = true;
  bool iSmenuItemEmpty = false;

  static Server server = Server();
  static CategoryWiseItemModel categoryWiseItemModel = CategoryWiseItemModel();
  @override
  void onInit() {
    getCategoryList();

    super.onInit();
  }

  void setCategoryIndex(int index) {
    selectedCategoryIndex = index;
    update();
  }

  getCategoryList() async {
    menuLoader = true;
    update();
    var categoryData = await CategoryRepo.getCategory();
    if (categoryData != null) {
      categoryDataList = categoryData.data!;
      menuLoader = false;
      update();
    } else {
      menuLoader = false;
      update();
    }
  }

  getItemDataList() async {
    itemLoader = true;
    update();
    var itemData = await ItemRepo.getItem();
    categoryItemDataList = <ItemData>[];
    if (itemData != null) {
      categoryItemDataList = itemData.data!;
      categoryItemVgDataList = itemData.data!;
      itemLoader = false;
      update();
    } else {
      update();
    }
  }

  getCategoryWiseItemDataList(String slug) async {
    categoryItemDataList.clear();
    categoryItemVgDataList.clear();
    menuItemLoader = true;
    await server
        .getRequestWithoutToken(
      endPoint: APIList.categoryWiseItem! + slug.toString(),
    )
        .then((response) {
      if (response != null && response.statusCode == 200) {
        menuItemLoader = false;
        iSmenuItemEmpty = false;
        update();
        final jsonResponse = json.decode(response.body);
        categoryWiseItemModel = CategoryWiseItemModel.fromJson(jsonResponse);
        // categoryItemDataList = categoryWiseItemModel.data!.items!;
        categoryItemVgDataList = categoryWiseItemModel.data!.items!;
        if (vegNonVegActiveList != 0) {
          categoryItemVgDataList.forEach((element) {
            if (vegNonVegActiveList == (element.itemType)) {
              categoryItemDataList.add(element);
            }
            update();
          });
        } else {
          categoryItemDataList = categoryWiseItemModel.data!.items!;
        }
        update();
        return categoryWiseItemModel.data!.items;
      } else {
        menuItemLoader = false;
        iSmenuItemEmpty = true;
        update();
      }
    });
  }

  getItemVgDataList(type, slug) async {
    if (vegNonVegActiveList == type) {
      vegNonVegActiveList = 0;
    } else {
      vegNonVegActiveList = type;
    }
    itemLoader = true;
    update();
    categoryItemDataList = <ItemData>[];
    categoryItemVgDataList.forEach((element) {
      if (vegNonVegActiveList == (element.itemType)) {
        categoryItemDataList.add(element);
      }
      if (vegNonVegActiveList == 0) {
        getCategoryWiseItemDataList(slug);
      }
      itemLoader = false;
      update();
    });

    update();
  }
}
