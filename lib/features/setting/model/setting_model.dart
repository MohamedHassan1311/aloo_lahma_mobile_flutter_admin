import 'package:aloo_lahma_admin/data/config/mapper.dart';

class SettingModel extends SingleMapper {
  int? id;
  String? urlSite;
  String? nameAr;
  String? nameEn;
  String? email;
  String? arInstitutionName;
  String? enInstitutionName;
  String? institutionTaxNumber;
  String? mobile;
  int? androidForcedUpdate;
  int? iosForcedUpdate;
  String? contentAr;
  String? contentEn;
  String? addressAr;
  String? addressEn;
  String? whatsapp;
  int? hoursBeforeOrder;
  String? googleAppUrl;
  String? appleAppUrl;
  String? facebook;
  String? instagram;
  String? messenger;
  String? twitter;
  String? snapchat;
  double? longitude;
  double? latitude;
  String? startTime;
  String? endTime;
  String? taxNumber;
  int? maroof;
  String? complaintNumber;
  String? customerNumber;
  String? deliveryMessageAr;
  String? deliveryMessageEn;
  String? defaultColor;
  String? secondaryColor;
  String? sacrificePrice;
  String? specialDeliveryLimit;

  SettingModel({
    this.id,
    this.urlSite,
    this.nameAr,
    this.nameEn,
    this.email,
    this.arInstitutionName,
    this.enInstitutionName,
    this.institutionTaxNumber,
    this.mobile,
    this.androidForcedUpdate,
    this.iosForcedUpdate,
    this.contentAr,
    this.contentEn,
    this.whatsapp,
    this.hoursBeforeOrder,
    this.googleAppUrl,
    this.appleAppUrl,
    this.facebook,
    this.instagram,
    this.messenger,
    this.twitter,
    this.snapchat,
    this.startTime,
    this.endTime,
    this.taxNumber,
    this.maroof,
    this.complaintNumber,
    this.customerNumber,
    this.deliveryMessageAr,
    this.deliveryMessageEn,
    this.defaultColor,
    this.secondaryColor,
    this.sacrificePrice,
    this.specialDeliveryLimit,
    this.addressAr,
    this.addressEn,
    this.longitude,
    this.latitude,
  });

  SettingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urlSite = json['url_site'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    email = json['email'];
    arInstitutionName = json['ar_institution_name'];
    enInstitutionName = json['en_institution_name'];
    institutionTaxNumber = json['institution_tax_number'];
    mobile = json['mobile'];
    androidForcedUpdate = json['android_forced_update'];
    iosForcedUpdate = json['ios_forced_update'];
    contentAr = json['content_ar'];
    contentEn = json['content_en'];
    addressAr = json['address_ar'];
    addressEn = json['address_en'];
    whatsapp = json['whatsapp'];
    hoursBeforeOrder = json['hours_before_order'];
    googleAppUrl = json['google_app_url'];
    appleAppUrl = json['apple_app_url'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    messenger = json['messenger'];
    twitter = json['twitter'];
    snapchat = json['snapchat'];
    longitude = double.parse(json['longitude']?.toString() ?? '0');
    latitude = double.parse(json['latitude']?.toString() ?? '0');
    startTime = json['start_time'];
    endTime = json['end_time'];
    taxNumber = json['tax_number'];
    maroof = json['maroof'];
    complaintNumber = json['complaintـnumber'];
    customerNumber = json['customerـnumber'];
    deliveryMessageAr = json['delivery_message_ar'];
    deliveryMessageEn = json['delivery_message_en'];
    defaultColor = json['default_color'];
    secondaryColor = json['secondary_color'];
    sacrificePrice = json['sacrifice_price'];
    specialDeliveryLimit = json['special_delivery_limit'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url_site'] = urlSite;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['email'] = email;
    data['ar_institution_name'] = arInstitutionName;
    data['en_institution_name'] = enInstitutionName;
    data['institution_tax_number'] = institutionTaxNumber;
    data['mobile'] = mobile;
    data['android_forced_update'] = androidForcedUpdate;
    data['ios_forced_update'] = iosForcedUpdate;
    data['content_ar'] = contentAr;
    data['content_en'] = contentEn;
    data['whatsapp'] = whatsapp;
    data['hours_before_order'] = hoursBeforeOrder;
    data['google_app_url'] = googleAppUrl;
    data['apple_app_url'] = appleAppUrl;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['messenger'] = messenger;
    data['twitter'] = twitter;
    data['snapchat'] = snapchat;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['tax_number'] = taxNumber;
    data['maroof'] = maroof;
    data['complaintـnumber'] = complaintNumber;
    data['customerـnumber'] = customerNumber;
    data['delivery_message_ar'] = deliveryMessageAr;
    data['delivery_message_en'] = deliveryMessageEn;
    data['default_color'] = defaultColor;
    data['secondary_color'] = secondaryColor;
    data['sacrifice_price'] = sacrificePrice;
    data['special_delivery_limit'] = specialDeliveryLimit;
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return SettingModel.fromJson(json);
  }
}
