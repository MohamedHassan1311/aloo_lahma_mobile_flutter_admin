import '../../../main_models/custom_field_model.dart';

class AddressModel {
  int? id;
  double? lat, lng;
  String? addressName, addressDetails, phone;
  String? createdAt;
  CustomFieldModel? city, neighborhood;
  bool? isDefault;

  Function(AddressModel address)? onSuccess;

  AddressModel({
    this.id,
    this.lat,
    this.lng,
    this.addressName,
    this.addressDetails,
    this.phone,
    this.city,
    this.neighborhood,
    this.isDefault,
    this.createdAt,
    this.onSuccess,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressName = json['address_name'];
    addressDetails = json['address'];
    lng = double.tryParse(json['lng']?.toString() ?? "0");
    lat = double.tryParse(json['lat']?.toString() ?? "0");
    phone = json['phone']?.toString();
    city =
        json['city'] != null ? CustomFieldModel.fromJson(json['city']) : null;
    neighborhood = json['neighborhood'] != null
        ? CustomFieldModel.fromJson(json['neighborhood'])
        : null;
    isDefault = json['default'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address_name'] = addressName;
    data['address'] = addressDetails;
    data['lng'] = lng;
    data['lat'] = lat;
    data['phone'] = phone;
    data['city'] = city?.toJson();
    data['neighborhood'] = neighborhood?.toJson();
    data['default'] = isDefault;
    data['created_at'] = createdAt;

    return data;
  }
}
