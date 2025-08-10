import '../../../data/config/mapper.dart';
import '../enums/order_details_enums.dart';
import '../enums/order_details_enums_converter.dart';

class OrderStatusModel extends SingleMapper {
  OrderStatuses? statusCode;
  String? status;
  String? image;
  String? color;
  bool? isCurrent;
  DateTime? createdAt;

  OrderStatusModel(
      {this.status,
      this.statusCode,
      this.image,
      this.color,
      this.isCurrent,
      this.createdAt});

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'] != null
        ? OrderDetailsEnumsConverter.convertStringToEnum(json['status_code'])
        : null;
    image = json['image'];
    isCurrent = json['is_current'];
    color = json["color"];
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode?.name;
    data['image'] = image;
    data['is_current'] = isCurrent;
    data['color'] = color;
    data['created_at'] = createdAt?.toIso8601String();
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return OrderStatusModel.fromJson(json);
  }
}
