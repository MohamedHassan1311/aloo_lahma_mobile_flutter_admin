class OrderProductModel {
  int? id;
  String? cover;
  String? name;
  ProductModel? gift;
  List<OptionItemModel>? items;
  int? quantity;
  int? amount;
  String? notes;
  String? createdAt;

  OrderProductModel(
      {this.id,
      this.name,
      this.cover,
      this.gift,
      this.items,
      this.quantity,
      this.amount,
      this.notes,
      this.createdAt});

  OrderProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    gift = json['gift'] != null ? ProductModel.fromJson(json['gift']) : null;
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(OptionItemModel.fromJson(v));
      });
    }
    quantity = json['quantity'];
    amount = json['amount'];
    notes = json['notes'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['gift'] = gift?.toJson();
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['notes'] = notes;
    data['created_at'] = createdAt;
    return data;
  }
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  String? weightDesc;
  String? cover;
  String? discountType;
  double? discount;
  double? price;
  double? priceAfter;
  bool? hasGift;
  bool? isFav;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.weightDesc,
    this.cover,
    this.discountType,
    this.discount,
    this.price,
    this.priceAfter,
    this.hasGift,
    this.isFav,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    cover = json["cover"];
    name = json["name"];
    description = json["description"];
    weightDesc = json["weight_desc"];
    discountType = json["discount_type"];
    discount = double.tryParse(json["discount"]?.toString() ?? "0");
    price = double.parse(json["price"]?.toString() ?? "0");
    priceAfter = json["price_after_discount"] != null
        ? double.parse(json["price_after_discount"].toString())
        : null;
    hasGift = json["has_gift"] ?? false;
    isFav = json["is_favourite"] ?? false;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "description": description,
        "weight_desc": weightDesc,
        "discount_type": discountType,
        "discount": discount,
        "price": price,
        "price_after_discount": priceAfter,
        "has_gift": hasGift,
        "is_favourite": isFav,
      };
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
    stock = json['stock'] ?? json['quantity'] ?? 100000;
    quantity = json['cart_quantity'] ?? json['quantity'] ?? 1;
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

