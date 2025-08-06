import 'package:zurex_admin/data/config/mapper.dart';

class SettingModel extends SingleMapper {
  GeneralModel? general;
  SocialModel? social;
  AppRulesModel? appRules;
  ContactUsModel? contactUs;
  PriceModel? price;

  SettingModel({general, social, appRules, price});

  SettingModel.fromJson(Map<String, dynamic> json) {
    general =
        json['general'] != null ? GeneralModel.fromJson(json['general']) : null;
    social =
        json['social'] != null ? SocialModel.fromJson(json['social']) : null;
    appRules = json['app_rules'] != null
        ? AppRulesModel.fromJson(json['app_rules'])
        : null;
    contactUs = json['contact_us'] != null
        ? ContactUsModel.fromJson(json['contact_us'])
        : null;
    price = json['price'] != null ? PriceModel.fromJson(json['price']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['general'] = general?.toJson();
    data['social'] = social?.toJson();
    data['app_rules'] = appRules?.toJson();
    data['contact_us'] = contactUs?.toJson();
    data['price'] = price?.toJson();

    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return SettingModel.fromJson(json);
  }
}

class GeneralModel {
  String? siteNameAr;
  String? siteNameEn;
  String? siteLogo;
  String? splashLogo;
  String? splashVideo;

  GeneralModel({siteNameAr, siteNameEn, siteLogo, splashLogo, splashVideo});

  GeneralModel.fromJson(Map<String, dynamic> json) {
    siteNameAr = json['site_name_ar'];
    siteNameEn = json['site_name_en'];
    siteLogo = json['site_logo'];
    splashLogo = json['splash_logo'];
    splashVideo = json['splash_video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['site_name_ar'] = siteNameAr;
    data['site_name_en'] = siteNameEn;
    data['site_logo'] = siteLogo;
    data['splash_logo'] = splashLogo;
    data['splash_video'] = splashVideo;
    return data;
  }
}

class SocialModel {
  String? whatsApp;
  String? facebook;
  String? twitter;
  String? tiktok;
  String? snapchat;
  String? instagram;
  String? website;

  SocialModel(
      {this.whatsApp,
      this.facebook,
      this.twitter,
      this.tiktok,
      this.snapchat,
      this.instagram,
      this.website});

  SocialModel.fromJson(Map<String, dynamic> json) {
    whatsApp = json['whatsApp'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    snapchat = json['snapchat'];
    instagram = json['instagram'];
    website = json['website'];
    tiktok = json['tiktok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['whatsapp_link'] = whatsApp;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['snapchat'] = snapchat;
    data['instagram'] = instagram;
    data['website'] = website;
    data['tiktok'] = tiktok;
    return data;
  }
}

class AppRulesModel {
  String? privacyPolicy;
  String? termsAndConditions;

  AppRulesModel({privacyPolicy, termsAndConditions});

  AppRulesModel.fromJson(Map<String, dynamic> json) {
    privacyPolicy = json['privacy_and_policy'];
    termsAndConditions = json['terms_and_conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['terms_and_conditions'] = termsAndConditions;
    data['privacy_and_policy'] = privacyPolicy;
    return data;
  }
}

class ContactUsModel {
  String? phone;
  String? email;

  ContactUsModel({this.phone, this.email});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}

class PriceModel {
  double? minPurchaseAmount;

  PriceModel({this.minPurchaseAmount});

  PriceModel.fromJson(Map<String, dynamic> json) {
    minPurchaseAmount =
        double.tryParse(json['min_purchase_amount']?.toString() ?? "0");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min_purchase_amount'] = minPurchaseAmount;
    return data;
  }
}
