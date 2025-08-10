import '../../../data/config/mapper.dart';
import '../../../main_models/meta.dart';
import '../enum/notification_target_enum.dart';

class NotificationsModel extends SingleMapper {
  String? status;
  String? message;
  List<NotificationModel>? data;
  Meta? meta;

  NotificationsModel({
    this.status,
    this.message,
    this.data,
  });

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;

    data = json["data"] == null
        ? []
        : List<NotificationModel>.from(
            json["data"]!.map((x) => NotificationModel.fromJson(x)));
  }

  @override
  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return NotificationsModel.fromJson(json);
  }
}

class NotificationModel extends SingleMapper {
  String? id;
  bool? isRead;
  String? title;
  String? body;
  NotifyTargetModel? target;
  DateTime? createdAt;

  NotificationModel({
    this.id,
    this.isRead,
    this.target,
    this.title,
    this.body,
    this.createdAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    isRead = json['read_at'] != null;
    target = json['target'] != null
        ? NotifyTargetModel.fromJson(json['target'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['read_at'] = isRead;
    data['created_at'] = createdAt?.toIso8601String();
    data['target'] = target?.toJson();
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return NotificationModel.fromJson(json);
  }
}

class NotifyTargetModel {
  int? id;
  NotificationTarget? name;


  NotifyTargetModel({
    this.id,
    this.name,
  });

  NotifyTargetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = NotificationTargetConverter.convertStringToEnum(
        json['name'] ?? 'product');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name?.name;
    return data;
  }
}
