import '../../../data/config/mapper.dart';

class OrderScheduleModel extends SingleMapper {
  int? id;
  String? name;
  String? from;
  String? to;
  OrderScheduleModel({
    this.id,
    this.name,
    this.from,
    this.to,
  });

  OrderScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    from = json["start_delivery_time"];
    to = json["end_delivery_time"];
    name = json["name"] ?? "$from - $to";
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start_delivery_time": from,
        "end_delivery_time": to,
      };

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return OrderScheduleModel.fromJson(json);
  }
}
