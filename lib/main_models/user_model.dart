import 'package:aloo_lahma_admin/data/config/mapper.dart';
import 'package:aloo_lahma_admin/features/profile/enums/user_types_enum.dart';

import '../features/profile/enums/user_types_enum_converter.dart';

class UserModel extends SingleMapper {
  int? id;
  String? name;
  String? profileImage;
  String? countryCode;
  String? phone;
  String? email;
  UserType? userType;
  double? balance;

  UserModel({
    this.id,
    this.name,
    this.profileImage,
    this.balance,
    this.countryCode,
    this.phone,
    this.email,
    this.userType,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    balance = json['balance'] != null ? double.parse(json["balance"]?.toString() ?? "0") : null;
    profileImage = json['profile_image'];
    countryCode = json['country_code'];
    phone = json['phone_number'];
    email = json['email'];
    userType = UserTypeEnumConverter.convertUserTypeFromStringToEnum(json['type']);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['balance'] = balance;
    data['profile_image'] = profileImage;
    data['phone_number'] = phone;
    data['email'] = email;
    data['type'] = userType?.name;

    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
