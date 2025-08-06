import 'package:zurex_admin/main_models/custom_field_model.dart';
import 'package:zurex_admin/main_models/user_model.dart';

import '../../../app/localization/language_constant.dart';
import '../../../data/config/mapper.dart';
import '../../../main_models/purchased_product_model.dart';

class OrderDetailsModel extends SingleMapper {
  int? id;
  String? orderNum;
  String? deliveryDate;
  CustomFieldModel? deliveryTime;
  BillModel? bill;
  List<PurchasedProductModel>? products;
  List<StatusModel>? statuses;
  String? status, statusCode;
  AddressModel? address;
  UserModel? user;
  DateTime? createdAt;

  OrderDetailsModel({
    this.id,
    this.orderNum,
    this.deliveryDate,
    this.deliveryTime,
    this.bill,
    this.products,
    this.statuses,
    this.address,
    this.status,
    this.statusCode,
    this.user,
    this.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNum,
        "status_code": statusCode,
        "status": status,
        "delivery_date": deliveryDate,
        "delivery_time": deliveryTime?.toJson(),
        "user": user?.toJson(),
        "bill": bill?.toJson(),
        "address": address?.toJson(),
        "status_list": statuses != null
            ? List<dynamic>.from(statuses!.map((x) => x.toJson()))
            : [],
        "products": products != null
            ? List<dynamic>.from(products!.map((x) => x.toJson()))
            : [],
        "created_at": createdAt?.toIso8601String(),
      };

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNum = json['order_number'];
    status = json['status'];
    statusCode = json['status_code'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'] != null
        ? CustomFieldModel.fromJson(json['delivery_time'])
        : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    bill = json['bill'] != null ? BillModel.fromJson(json['bill']) : null;
    address =
        json['address'] != null ? AddressModel.fromJson(json['address']) : null;
    if (json['status_list'] != null) {
      statuses = [];
      json['status_list'].forEach((v) {
        statuses!.add(StatusModel.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(PurchasedProductModel.fromJson(v));
      });
    }
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel.fromJson(json);
  }
}

class StatusModel {
  String? status, statusCode;
  String? image;
  bool? isCurrent;
  DateTime? createdAt;

  StatusModel(
      {this.status,
      this.statusCode,
      this.image,
      this.isCurrent,
      this.createdAt});

  StatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    image = json['image'];
    isCurrent = json['is_current'];
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['image'] = image;
    data['is_current'] = isCurrent;
    data['created_at'] = createdAt?.toIso8601String();
    return data;
  }
}

class AddressModel {
  int? id;
  double? latitude;
  double? longitude;
  String? fullAddress;

  AddressModel({
    this.id,
    this.latitude,
    this.longitude,
    this.fullAddress,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullAddress = json['full_address'];
    latitude =
        json['latitude'] != null ? double.tryParse(json['latitude']) : null;
    longitude =
        json['longitude'] != null ? double.tryParse(json['longitude']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['full_address'] = fullAddress;
    return data;
  }
}

class BillModel extends SingleMapper {
  double? subTotal;
  double? tax;
  double? taxPercentage;
  double? fees;
  double? feesPercentage;
  double? discount;
  double? totalPrice;
  String? currency;

  BillModel(
      {this.subTotal,
      this.taxPercentage,
      this.tax,
      this.fees,
      this.feesPercentage,
      this.discount,
      this.totalPrice,
      this.currency});

  BillModel.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'] != null
        ? double.parse(json['sub_total'].toString())
        : null;
    taxPercentage = json['tax_percentage'] != null
        ? double.parse(json['tax_percentage'].toString())
        : null;
    tax = json['tax_value'] != null
        ? double.parse(json['tax_value'].toString())
        : null;
    feesPercentage = json['fees_percentage'] != null
        ? double.parse(json['fees_percentage'].toString())
        : null;
    fees = json['fees_value'] != null
        ? double.parse(json['fees_value'].toString())
        : null;
    discount = json['discount'] != null
        ? double.parse(json['discount'].toString())
        : json['discount'] != null
            ? double.parse(json['discount'].toString())
            : null;

    totalPrice = json['total_price'] != null
        ? double.parse(json['total_price'].toString())
        : null;

    currency = json['currency'] ?? getTranslated("sar");
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_total'] = subTotal;
    data['tax_percentage'] = taxPercentage;
    data['tax_value'] = tax;
    data['fees_percentage'] = feesPercentage;
    data['fees_value'] = fees;
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    data['currency'] = currency;
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return BillModel.fromJson(json);
  }
}

enum OrderStatus {
  pending,
  accepted,
  processing,
  out_for_delivery,
  delivered,
  cancelled,
  paid_failed,
}
