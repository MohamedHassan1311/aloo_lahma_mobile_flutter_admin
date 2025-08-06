import '../../../data/config/mapper.dart';
import '../../../main_models/meta.dart';

class OrdersModel extends SingleMapper {
  String? message;
  int? statusCode;
  List<OrderModel>? data;
  Meta? meta;

  OrdersModel({
    this.message,
    this.statusCode,
    this.data,
    this.meta,
  });

  @override
  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "pagination": meta?.toJson(),
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [],
      };

  OrdersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    meta =
        json['pagination'] != null ? Meta.fromJson(json['pagination']) : null;

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(OrderModel.fromJson(v));
      });
    }
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return OrdersModel.fromJson(json);
  }
}

class OrderModel extends SingleMapper {
  int? id;
  String? orderNum;
  double? total;
  String? status;
  DateTime? createdAt;

  OrderModel({
    this.id,
    this.orderNum,
    this.total,
    this.status,
    this.createdAt,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNum = json['order_number'];
    total = json['bill'] != null && json["bill"]['total_price'] != null
        ? double.tryParse(json["bill"]['total_price']?.toString() ?? "0")
        : null;
    status = json['status'];
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_number'] = orderNum;
    data['total_price'] = total;
    data['status'] = status;
    data['created_at'] = createdAt?.toIso8601String();
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return OrderModel.fromJson(json);
  }
}
