import '../../../data/config/mapper.dart';
import '../../../main_models/meta.dart';
import '../../order_details/enums/order_details_enums.dart';
import '../../order_details/enums/order_details_enums_converter.dart';
import '../../order_details/model/order_schedule_model.dart';
import '../../order_details/model/payment_model.dart';

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
        "meta": meta?.toJson(),
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [],
      };

  OrdersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;

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
  double? amount;
  String? status;
  ReceiptTypes? deliveryType;
  DateTime? deliveryDay;
  OrderScheduleModel? deliveryTime;
  PaymentModel? payType;
  String? timeReceipt;
  DateTime? createdAt;

  OrderModel({
    this.id,
    this.orderNum,
    this.amount,
    this.status,
    this.deliveryType,
    this.deliveryDay,
    this.deliveryTime,
    this.timeReceipt,
    this.payType,
    this.createdAt,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNum = json['order_number'];
    amount = double.tryParse(json["amount"]?.toString() ?? "0");
    status = json['status'];
    deliveryType = json['delivery_type'] != null
        ? OrderDetailsEnumsConverter.convertStringToReceiptType(
            json['delivery_type'])
        : null;
    deliveryDay = json['delivery_day'] != null
        ? DateTime.parse(json['delivery_day'])
        : null;

    deliveryTime = json['delivery_time'] != null
        ? OrderScheduleModel.fromJson(json['delivery_time'])
        : null;
    timeReceipt = json['time_receipt'];
    payType =
        json['invoice'] != null && json['invoice']['pay_type_object'] != null
            ? PaymentModel.fromJson(json['invoice']['pay_type_object'])
            : null;

    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_number'] = orderNum;
    data['amount'] = amount;
    data['status'] = status;
    data['delivery_type'] = OrderDetailsEnumsConverter.convertReceiptTypeEnumToString(deliveryType);
    data['delivery_day'] = deliveryDay?.toIso8601String();
    data['delivery_time'] = deliveryTime?.toJson();
    data['pay_type_object'] = payType?.toJson();
    data['time_receipt'] = timeReceipt;
    data['created_at'] = createdAt?.toIso8601String();
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return OrderModel.fromJson(json);
  }
}
