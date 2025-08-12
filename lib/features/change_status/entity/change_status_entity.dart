import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:aloo_lahma_admin/features/order_details/model/address_model.dart';
import 'package:aloo_lahma_admin/main_models/user_model.dart';
import 'package:flutter/cupertino.dart';
import '../../delivery_times/model/order_schedule_model.dart';
import '../../order_details/enums/order_details_enums.dart';
import '../../order_details/model/order_status_model.dart';

class ChangeStatusEntity {
  int? id;
  DateTime? deliveryDate;
  DateTime? receiptTime;
  OrderScheduleModel? deliveryTime;
  ReceiptTypes? receiptType;
  AddressModel? address;
  UserModel? driver;
  OrderStatusModel? status;
  TextEditingController? cancelReason;

  ChangeStatusEntity({
    this.id,
    this.deliveryDate,
    this.deliveryTime,
    this.receiptTime,
    this.receiptType,
    this.address,
    this.driver,
    this.status,
    this.cancelReason,
  });

  ChangeStatusEntity copyWith({
    DateTime? deliveryDate,
    DateTime? receiptTime,
    OrderScheduleModel? deliveryTime,
    bool? clearDeliveryTime,
    UserModel? driver,
    OrderStatusModel? status,
  }) {
    this.status = status ?? this.status;
    this.driver = driver ?? this.driver;
    this.deliveryDate = deliveryDate ?? this.deliveryDate;
    this.deliveryTime = deliveryTime ?? this.deliveryTime;
    if (clearDeliveryTime == true) {
      this.deliveryTime = null;
      this.receiptTime = null;
    } else {
      this.deliveryTime = deliveryTime ?? this.deliveryTime;
      this.receiptTime = receiptTime ?? this.receiptTime;
    }

    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cancel_reason'] = cancelReason?.text.trim();
    data['delivery_date'] = deliveryDate?.dateFormat(format: "y-MM-d", lang: "en");
    if (receiptType == ReceiptTypes.delivery) {
      data['deliver_time_id'] = deliveryTime?.id;
    } else {
      data['time_receipt'] = receiptTime?.dateFormat(format: "hh:mm a", lang: "en");
    }
    data['driver_id'] = driver?.id;

    data.removeWhere((key, value) => value == null || value == "");
    return data;
  }
}
