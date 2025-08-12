import 'package:aloo_lahma_admin/features/order_details/enums/order_details_enums_converter.dart';
import 'package:aloo_lahma_admin/features/order_details/model/payment_model.dart';
import '../../../data/config/mapper.dart';
import '../../../main_models/user_model.dart';
import '../enums/order_details_enums.dart';
import 'address_model.dart';
import 'order_invoice_model.dart';
import 'order_product_model.dart';
import 'order_schedule_model.dart';
import 'order_status_model.dart';

class OrderDetailsModel extends SingleMapper {
  int? id;
  String? orderNum;
  DateTime? deliveryDay;
  OrderScheduleModel? deliveryTime;
  String? timeReceipt;
  String? cancelReason;
  ReceiptTypes? deliveryType;
  OrderInvoiceModel? bill;
  PaymentMethodModel? bank;
  List<OrderProductModel>? products;
  List<OrderStatusModel>? statuses;
  List<OrderStatusModel>? availableStatus;

  String? status;
  OrderStatuses? currentStatus;
  AddressModel? address;
  PaymentModel? payType;
  UserModel? user;
  UserModel? driver;
  DateTime? createdAt;

  OrderDetailsModel({
    this.id,
    this.orderNum,
    this.deliveryDay,
    this.deliveryTime,
    this.timeReceipt,
    this.deliveryType,
    this.bill,
    this.products,
    this.statuses,
    this.availableStatus,
    this.address,
    this.status,
    this.currentStatus,
    this.payType,
    this.user,
    this.driver,
    this.cancelReason,
    this.bank,
    this.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNum,
        "status": status,
        "status_code": currentStatus?.name,
        "delivery_day": deliveryDay?.toIso8601String(),
        "delivery_time": deliveryTime?.toJson(),
        "time_receipt": timeReceipt,
        "cancel_reason": cancelReason,
        "delivery_type":
            OrderDetailsEnumsConverter.convertReceiptTypeEnumToString(
                deliveryType),
        "invoice": bill?.toJson(),
        "invoice[shipping]": address?.toJson(),
        "pay_type_object": payType?.toJson(),
        "invoice[user]": user?.toJson(),
        "driver": driver?.toJson(),
        "status_logs": statuses != null
            ? List<dynamic>.from(statuses!.map((x) => x.toJson()))
            : [],
        "available_statuses": availableStatus != null
            ? List<dynamic>.from(availableStatus!.map((x) => x.toJson()))
            : [],
        "products": products != null
            ? List<dynamic>.from(products!.map((x) => x.toJson()))
            : [],
        "bank": bank?.toJson(),
        "created_at": createdAt?.toIso8601String(),
      };

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNum = json['order_number'];
    status = json['status'];
    cancelReason = json['cancel_reason'];
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
    user = json['invoice'] != null && json['invoice']['user'] != null
        ? UserModel.fromJson(json['invoice']['user'])
        : null;
    driver = json['driver'] != null ? UserModel.fromJson(json['driver']) : null;
    bill = json['invoice'] != null
        ? OrderInvoiceModel.fromJson(json['invoice'])
        : null;
    payType =
        json['invoice'] != null && json['invoice']['pay_type_object'] != null
            ? PaymentModel.fromJson(json['invoice']['pay_type_object'])
            : null;
    bank = json['invoice'] != null && json['invoice']['bank'] != null
        ? PaymentMethodModel.fromJson(json['invoice']['bank'])
        : null;
    address = json['invoice'] != null && json['invoice']['shipping'] != null
        ? AddressModel.fromJson(json['invoice']['shipping'])
        : null;

    if (json['status_logs'] != null) {
      statuses = [];
      json['status_logs'].forEach((v) {
        statuses!.add(OrderStatusModel.fromJson(v));
      });
    }

    statuses?.forEach((e) {
      if (e.isCurrent == true) {
        currentStatus = e.statusCode;
      }
    });

    if (json['available_statuses'] != null) {
      availableStatus = [];
      json['available_statuses'].forEach((v) {
        availableStatus!.add(OrderStatusModel.fromJson(v));
      });
    }

    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(OrderProductModel.fromJson(v));
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
