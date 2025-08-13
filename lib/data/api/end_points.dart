import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static const bool isProductionEnv = false;
  static String domain =
      dotenv.env['DOMAIN_${isProductionEnv ? "PRO" : "DEV"}'] ?? "";
  static String baseUrl =
      dotenv.env['BASE_URL_${isProductionEnv ? "PRO" : "DEV"}'] ?? "";
  static String apiKey = dotenv.env['API_KEY'] ?? "";
  static chatPort(id) => '${dotenv.env['CHAT_PORT']}$id';
  static String googleMapsBaseUrl = dotenv.env['GOOGLE_MAPS_BASE_URL'] ?? "";
  static const String generalTopic =
      isProductionEnv ? 'aloo_lahma' : 't_aloo_lahma';
  static String userTypeTopic(type) => isProductionEnv ? '$type' : 't_$type';
  static specificTopic(type, id) =>
      isProductionEnv ? '${type}_$id' : 't_${type}_$id';

  ///Auth
  static String forgetPassword(userType) => '$userType/forget-password';
  static String resetPassword(userType) => '$userType/reset-password';
  static String changePassword(userType) => '$userType/change-password';
  static String logIn(userType) => '$userType/login';
  static const String resend = 'resend-otp';
  static String verifyOtp(userType) => '$userType/verify-otp';
  static const String suspendAccount = 'suspend-account';
  static const String reactivateAccount = 'reactivate-account';

  ///User Profile
  static String editProfile(userType) => '$userType/update-profile';
  static String profile(userType) => '$userType/me';

  ///Chats
  static const String createChat = 'chats';
  static const String chats = 'chats';
  static deleteChat(id) => 'chats/$id';
  static chatDetails(id) => 'chats/$id';
  static chatMessages(id) => 'chat-messages/$id';
  static const String uploadFile = 'upload-file';

  ///Notification
  static String notifications(userType) => '$userType/notifications';
  static String readNotification(userType, id) =>
      '$userType/notifications/read/$id';
  static deleteNotification(id) => 'notifications/$id';

  ///Orders
  static String orders(userType) => '$userType/orders';
  static orderDetails(userType, id) => '$userType/orders/$id';
  static const String cancelReasons = 'cancel-reason';
  static changeOrderStatus(userType) => '$userType/orders/change-status';

  ///Drivers
  static String orderSchedule(userType) => '$userType/checkout/newGetPeriods';
  static String drivers(userType) => '$userType/drivers';

  ///Setting
  static const String settings = 'user/settings';
  static String pages(content) => 'user/pages/$content';
  static const String faqs = 'user/faqs';
  static const String contactUs = 'user/contact-us';
  static const String countryStates = 'country-states';

  ///Share
  static shareRoute(route, id) => "$baseUrl$route/?id=$id";

  ///Upload File Service
  static const String uploadFileService = 'store_attachment';

  /// maps
  static const String geoCodeUrl = '/maps/api/geocode/';
  static const String autoComplete = '/maps/api/place/autocomplete/';
//https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
//'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=n,&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
}
