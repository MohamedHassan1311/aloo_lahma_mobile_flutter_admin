import 'package:aloo_lahma_admin/data/config/mapper.dart';

class UserModel extends SingleMapper {
  int? id;
  String? name;
  String? profileImage;
  String? countryCode;
  String? mobile;
  String? email;
  double? balance;

  UserModel({
    this.id,
    this.name,
    this.profileImage,
    this.balance,
    this.countryCode,
    this.mobile,
    this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    balance = json['balance'] != null
        ? double.parse(json["balance"]?.toString() ?? "0")
        : null;
    profileImage = json['profile_image'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    email = json['email'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['balance'] = balance;
    data['profile_image'] = profileImage;
    data['mobile'] = mobile;
    data['email'] = email;

    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
