import 'package:zurex_admin/data/config/mapper.dart';

class LocationModel extends SingleMapper {
  int? addressId;
  double? latitude;
  double? longitude;
  String? address;
  Function(LocationModel)? onChange;

  LocationModel({
    this.addressId,
    this.address,
    this.latitude,
    this.longitude,
    this.onChange,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    address = json['address'];
    latitude = json['lat'];
    longitude = json['long'];
  }

  LocationModel copyWith({
    int? addressId,
    double? latitude,
    double? longitude,
    String? address,
    Function(LocationModel)? onChange,
  }) {
    this.addressId = addressId ?? this.addressId;
    this.address = address ?? this.address;
    this.latitude = latitude ?? this.latitude;
    this.longitude = longitude ?? this.longitude;
    this.onChange = onChange ?? this.onChange;
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['address'] = address;
    data['lat'] = latitude;
    data['long'] = longitude;

    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return LocationModel.fromJson(json);
  }
}
