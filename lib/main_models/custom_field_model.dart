import '../../../data/config/mapper.dart';
import 'meta.dart';

class CustomFieldsModel extends SingleMapper {
  String? message;
  int? statusCode;
  List<CustomFieldModel>? data;

  Meta? meta;

  CustomFieldsModel({
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

  CustomFieldsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    meta =
        json['pagination'] != null ? Meta.fromJson(json['pagination']) : null;

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(CustomFieldModel.fromJson(v));
      });
    }
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return CustomFieldsModel.fromJson(json);
  }
}

class CustomFieldModel extends SingleMapper {
  int? id;
  String? name;
  String? description;
  String? image;
  String? code;

  CustomFieldModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.code,
  });

  CustomFieldModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    name = json["name"] ?? json["title"] ?? "";
    description = json["desc"];
    code = json["code"];
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": description,
        "image": image,
        "code": code,
      };

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return CustomFieldModel.fromJson(json);
  }
}
