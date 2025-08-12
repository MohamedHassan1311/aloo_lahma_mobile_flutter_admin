import 'package:aloo_lahma_admin/main_models/user_model.dart';
import '../../../data/config/mapper.dart';
import '../../../main_models/meta.dart';

class DriversModel extends SingleMapper {
  String? message;
  int? statusCode;
  List<UserModel>? data;
  Meta? meta;

  DriversModel({
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

  DriversModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    meta =
        json['meta'] != null ? Meta.fromJson(json['meta']) : null;

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(UserModel.fromJson(v));
      });
    }
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return DriversModel.fromJson(json);
  }
}

