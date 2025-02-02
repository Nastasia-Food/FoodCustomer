class MainItem {
  int? id;
  int? quantity;
  String? name;
  double? price;
  String? image;
  MainItem({this.id, this.quantity, this.name, this.price, this.image});
}

class MainItemVariation {
  int? id;
  int? itemId;
  String? name;
  double? price;
  MainItemVariation({
    this.id,
    this.itemId,
    this.name,
    this.price,
  });
}

class ExtraItem {
  int? id;
  int? itemId;
  int? quantity;
  String? name;
  double? price;
  ExtraItem({
    this.id,
    this.itemId,
    this.quantity,
    this.name,
    this.price,
  });
}

class AddonsItem {
  int? id;
  int? itemId;
  int? quantity;
  String? name;
  double? price;
  AddonsItem({
    this.id,
    this.itemId,
    this.quantity,
    this.name,
    this.price,
  });
}

class ItemVariations {
  final Names names;
  final IVariations variations;

  ItemVariations(this.names, this.variations);
}

class IVariations {
  final int id;
  final int value;

  IVariations(this.id, this.value);
}

class Names {
  final String size;

  Names(this.size);
}
