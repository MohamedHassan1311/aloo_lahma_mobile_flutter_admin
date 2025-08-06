
class PurchasedProductModel {
  int? id;
  int? quantity;
  List<OptionModel>? options;
  String? name, image;
  double? totalPrice;
  String? discountType;
  double? discount;

  PurchasedProductModel(
      {this.id,
        this.quantity,
        this.options,
        this.name,
        this.image,
        this.discountType,
        this.discount,
        this.totalPrice});

  PurchasedProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    if (json['options'] != null) {
      options = <OptionModel>[];
      json['options'].forEach((v) {
        options!.add(OptionModel.fromJson(v));
      });
    }
    name = json['name'];
    image = json['image'];
    discountType = json["discount_type"];
    discount = double.tryParse(json["discount"]?.toString() ?? "0");
    totalPrice = double.tryParse(json["total_price"]?.toString() ?? "0");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['image'] = image;
    data['discount_type'] = discountType;
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    return data;
  }

  Map<String, dynamic> toCart() => {
    "id": id,
    "quantity": quantity,
    "options": options?.map((v) => v.toCart()).toList()
  };
}

class OptionModel {
  int? id;
  String? name;
  bool? hasQuantity;
  bool? isMulti;
  bool? isRequired;
  List<OptionItemModel>? items;

  OptionModel({
    this.id,
    this.name,
    this.hasQuantity,
    this.isMulti,
    this.isRequired,
    this.items,
  });

  OptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hasQuantity = json['have_quantity'] == 1;
    isMulti = json['is_multi'] == 1;
    isRequired = json['is_required'] == 1;
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(OptionItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['have_quantity'] = hasQuantity == true ? 1 : 0;
    data['is_multi'] = isMulti == true ? 1 : 0;
    data['is_required'] = isRequired == true ? 1 : 0;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toCart() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_multi'] = isMulti == true ? 1 : 0;
    data['is_required'] = isRequired == true ? 1 : 0;
    data['have_quantity'] = hasQuantity == true ? 1 : 0;
    if (items != null) {
      List<Map<String, dynamic>> selectItems = [];
      for (var i = 0; i < (items?.length ?? 0); i++) {
        if (items?[i].selected == true) {
          selectItems.add(items?[i].toCart() ?? {});
        }
      }
      data["items"] = selectItems;
    }
    return data;
  }
}

class OptionItemModel {
  int? id;
  String? name;
  double? price;
  double? priceAfter;
  int? quantity;
  int? stock;
  bool? selected;
  String? desc;

  OptionItemModel({
    this.id,
    this.name,
    this.price,
    this.priceAfter,
    this.quantity,
    this.stock,
    this.selected,
    this.desc,
  });

  OptionItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    price =
    json["price"] != null ? double.parse(json["price"].toString()) : null;
    priceAfter = json["price_after_discount"] != null
        ? double.parse(json["price_after_discount"].toString())
        : null;
    stock = json['stock'];
    quantity = json['cart_quantity'] ?? 1;
    selected = json['cart_quantity'] != null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['price'] = price;
    data['price_after_discount'] = priceAfter;
    data['cart_quantity'] = quantity;
    data['stock'] = stock;
    data['selected'] = selected;
    return data;
  }

  Map<String, dynamic> toCart() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    return data;
  }
}

enum DiscountType { percentage, amount }
