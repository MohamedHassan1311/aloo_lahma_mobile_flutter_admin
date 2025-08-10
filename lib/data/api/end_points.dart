import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static const bool isProductionEnv = true;
  static String domain =
      dotenv.env['DOMAIN_${isProductionEnv ? "PRO" : "DEV"}'] ?? "";
  static String baseUrl =
      dotenv.env['BASE_URL_${isProductionEnv ? "PRO" : "DEV"}'] ?? "";
  static String apiKey = dotenv.env['API_KEY'] ?? "";
  static chatPort(id) => '${dotenv.env['CHAT_PORT']}$id';
  static String googleMapsBaseUrl = dotenv.env['GOOGLE_MAPS_BASE_URL'] ?? "";
  static const String generalTopic =
      isProductionEnv ? 'aloo_lahma_admin' : 't_aloo_lahma';
  static String userTypeTopic(type) => isProductionEnv ? 'type' : 't_$type';
  static specificTopic(id) => isProductionEnv ? '$id' : 't_$id';

  ///Auth
  static String forgetPassword(userType) => '$userType/forgot-password';
  static String resetPassword(userType) => '$userType/reset-password';
  static String changePassword(userType) => '$userType/change-password';
  static String logIn(userType) => '$userType/login';
  static const String resend = 'resend-otp';
  static String verifyOtp(userType) => '$userType/verify-forgot-password';
  static const String suspendAccount = 'suspend-account';
  static const String reactivateAccount = 'reactivate-account';

  ///User Profile
  static const String editProfile = 'update-profile';
  static const String profile = 'me';

  ///Chats
  static const String createChat = 'chats';
  static const String chats = 'chats';
  static deleteChat(id) => 'chats/$id';
  static chatDetails(id) => 'chats/$id';
  static chatMessages(id) => 'chat-messages/$id';
  static const String uploadFile = 'upload-file';

  ///Notification
  static const String notifications = 'notifications';
  static readNotification(id) => 'notifications/$id';
  static deleteNotification(id) => 'notifications/$id';

  ///Orders
  static const String orders = 'orders';
  static orderDetails(id) => 'orders/$id';
  static const String cancelReasons = 'cancel-reason';
  static changeOrderStatus(id) => 'orders/$id/changeOrderStatus';

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
