import '../../../data/config/mapper.dart';

class PaymentModel extends SingleMapper {
  int? id;
  String? name;
  String? icon;
  String? code;
  String? translatedCode;
  List<PaymentMethodModel>? methods;
  bool hasChildren() => methods != null && methods!.isNotEmpty;
  PaymentMethodModel? childrenSelected() {
    PaymentMethodModel? selected;
    for (final method in methods!) {
      if (method.isSelected == true) {
        selected = method;
      }
    }
    return selected;
  }

  PaymentModel({
    this.id,
    this.name,
    this.icon,
    this.code,
    this.translatedCode,
    this.methods,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    icon = json["icon"];
    name = json["name"];
    code = json["code"];
    translatedCode = json["translated_code"];
    methods = json["children"] != null
        ? List<PaymentMethodModel>.from(
            json["children"].map((e) => PaymentMethodModel.fromJson(e)))
        : null;
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "code": code,
        "translated_code": code,
        "children": methods?.map((e) => e.toJson()).toList(),
      };

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return PaymentModel.fromJson(json);
  }
}

class PaymentMethodModel extends SingleMapper {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;
  String? code;
  String? iban;
  String? accountNumber;
  bool? isSelected;

  PaymentMethodModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.image,
    this.code,
    this.iban,
    this.accountNumber,
  });

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    id = json["PaymentMethodId"] ?? json['id'];
    image = json["ImageUrl"]??json['icon'];
    nameAr = json["PaymentMethodAr"] ?? json['name_ar'];
    nameEn = json["PaymentMethodEn"] ?? json['name_en'];
    code = json["PaymentMethodCode"];
    iban = json["i_ban"];
    accountNumber = json["account_number"];
    isSelected = false;
  }

  @override
  Map<String, dynamic> toJson() => {
        "PaymentMethodId": id,
        "PaymentMethodAr": nameAr,
        "PaymentMethodEn": nameEn,
        "ImageUrl": image,
        "i_ban": iban,
        "account_number": accountNumber,
        "PaymentMethodCode": code,
      };

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return PaymentModel.fromJson(json);
  }
}
