import 'package:aloo_lahma_admin/features/language/bloc/language_bloc.dart';

import '../../data/config/di.dart';

class AppStrings {
  static const String appName = 'الو لحمه للأعمال';
  static const String appStoreId = '13313131';
  static const String googleApiKey = 'AIzaSyA2xA7d84QkR0_0OPjdDRLfu--YbjJkSa8';
  static const String defaultAddress = 'البحرين ، المنامة';
  static const double defaultLat = 26.225513;
  static const double defaultLong = 50.589816;
  static const String arFontFamily = 'ar';
  static const String enFontFamily = 'en';
  static const String noRouteFound = 'No Route Found';
  static const String cachedRandomQuote = 'CACHED_RANDOM_QUOTE';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String serverFailure = 'Server Failure';
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
  static const String englishCode = 'en';
  static const String arabicCode = 'ar';
  static const String locale = 'locale';

  static tabbyUrl(price) =>
      "https://checkout.tabby.ai/promos/product-page/installments/${sl<LanguageBloc>().isLtr ? "en" : "ar"}/?price=$price&currency=sar&source=sdk&sdkType=flutter";

  static const tammaraKey =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhY2NvdW50SWQiOiI3ZDhiMzNkMC01NTA0LTRkZjUtYjgwNi05OGEwY2YzNzVlMmQiLCJ0eXBlIjoibWVyY2hhbnQiLCJzYWx0IjoiOTZkMGE3NWExOGRmYzI4Yjg2MzU5ZTJhYzM4ZDRhNGYiLCJyb2xlcyI6WyJST0xFX01FUkNIQU5UIl0sImlhdCI6MTY5OTI1MDU3OSwiaXNzIjoiVGFtYXJhIFBQIn0.M73zxM5Fr3ZRm-ebwcsrRxGm6U6SSs3vvy8ORh5H4JsFeTJ5gzFm4MTVU8YxOKocmLK4WAfdJsl8wTEb_9C34uJeoC7OK9KF7WSkhcQiUG_HiW6bhRZVikX1_rVXiA11q_W9YYZS7BcTLqkEb-LEqaObmKB4hH7sF7hExXbfIWXvDEfgfi9oFxYFpw0PaM0dbvOpwQh_pWhHjh1u_GNfLEJEayvg-rK50PfuZ0LNilfYt6uSgGSQJEEmaREVSIxAMGXFWxXkpXMPClnZFqvY1-I9dEzou3GFxOj7kIMFF71DXHR_iwj0PV3UJEUlTiK4f6oNs077h6Fd5hQ-TVXtPw";

  static tamaraUrl(price) =>
      "https://cdn-sandbox.tamara.co/widget-v2/tamara-widget.html?lang=${sl<LanguageBloc>().isLtr ? "en" : "ar"}&public_key=$tammaraKey&country=SA&amount=$price&inline_type=2";
}
