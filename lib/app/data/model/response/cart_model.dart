class MenuItem {
  int? id;
  String? name;
  String? imgUrl;
  double? price;
  double? discount;
  int? qty;
  double? avgRating;
  int? stockCount;
  bool? inStock;

  MenuItem({
    this.id,
    this.name,
    this.inStock,
    this.stockCount,
    this.avgRating,
    this.price,
    this.discount,
    this.qty,
    this.imgUrl,
  });
}

class OrderMenuItem {
  int? id;
  String? name;
  String? instructions;
  double? price;
  int? qty;
  String? imgUrl;
  int? stockCount;
  String? variationId;
  bool? inStock;
  List? options = [];

  OrderMenuItem(
      {this.id,
      this.name,
      this.instructions,
      this.inStock,
      this.stockCount,
      this.price,
      this.qty,
      this.imgUrl,
      this.options,
      this.variationId});
}

// class ItemMenuItem {
//   String? restaurantId;
//   int? menuItemId;
//   double? discountedPrice;
//   double? unitPrice;
//   int? quantity;
//   String? shopMenuItemVariationId;
//   List? options = [];

//   ItemMenuItem(
//       {this.restaurantId,
//       this.menuItemId,
//       this.unitPrice,
//       this.quantity,
//       this.discountedPrice,
//       this.shopMenuItemVariationId,
//       this.options});

//   Map<String, dynamic> toJsonData() {
//     var map = new Map<String, dynamic>();
//     map["restaurant_id"] = restaurantId;
//     map["shop_MenuItem_variation_id"] = shopMenuItemVariationId;
//     map["MenuItem_id"] = menuItemId;
//     map["unit_price"] = unitPrice;
//     map["quantity"] = quantity;
//     map["discounted_price"] = discountedPrice;
//     map["options"] = options;
//     return map;
//   }
// }

// class Options {
//   String? id;
//   String? name;
//   String? price;
//   Options({this.id, this.name, this.price});
//   Map<String, dynamic> toJsonData() {
//     var map = new Map<String, dynamic>();
//     map["id"] = id;
//     map["name"] = name;
//     map["price"] = price;
//     return map;
//   }
// }

// class ItemProduct {
//   String? instructions;
//   String? restaurantId;
//   int? menuItemId;
//   double? discountedPrice;
//   double? unitPrice;
//   int? quantity;
//   String? menuItemVariationId;
//   List? options = [];

//   ItemProduct(
//       {this.instructions,
//       this.restaurantId,
//       this.menuItemId,
//       this.unitPrice,
//       this.quantity,
//       this.discountedPrice,
//       this.menuItemVariationId,
//       this.options});

//   Map<String, dynamic> toJsonData() {
//     var map = new Map<String, dynamic>();
//     map["instructions"] = instructions;
//     map["restaurant_id"] = restaurantId;
//     map["menu_item_variation_id"] = menuItemVariationId;
//     map["menuItem_id"] = menuItemId;
//     map["unit_price"] = unitPrice;
//     map["quantity"] = quantity;
//     map["discounted_price"] = discountedPrice;
//     map["options"] = options;
//     return map;
//   }
// }
