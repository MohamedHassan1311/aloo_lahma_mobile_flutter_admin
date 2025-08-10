import 'package:flutter/material.dart';

abstract class Styles {
  static const Color ACCENT_COLOR = Color(0xFF00AF2C);
  static const Color PRIMARY_COLOR = Color(0xffe3342f);
  static const Color kPrimary300 = Color(0xFFee7c78);
  static const Color kPrimary100 = Color(0xFFF9D3D2);
  static const Color APP_BAR_BACKGROUND_COLOR = Color(0xffFFF9F9);
  static const Color BACKGROUND_COLOR = Color(0xFFFfffff);
  static const Color CONTAINER_BACKGROUND_COLOR = Color(0xffF3F3F3);
  static const Color BLUE_COLOR = Color(0xff3A5ACD);
  static const Color SYSTEM_COLOR = Color(0xff007AFF);
  static const Color RATE_COLOR = Color(0xffFFC600);
  static const Color NAV_BAR_BACKGROUND_COLOR = Color(0xFFFFFFFF);
  static const Color ACTIVE = Color(0xff209370);
  static const Color IN_ACTIVE = Color(0xFFDB5353);
  static const Color PENDING = Color(0xffDBAB02);
  static const Color PLACE_HOLDER = Color(0xFF7F8B93);

  static const Color FILL_COLOR = Color(0xFFF0F0F0);

  // static const Color FILL_COLOR = Color(0xFFFAFAFA);
  static const Color DISABLED = Color(0xFF949494);
  static const Color WHITE_COLOR = Color(0xFFFFFFFF);
  static const Color SMOKED_WHITE_COLOR = Color(0xFFF6F6F6);
  static const Color OFFER_COLOR = Color(0xff22BB55);
  static const Color LOGOUT_COLOR = Color(0xffDF4759);
  static const Color GREEN = Color(0xff00AF2C);
  static const Color GREY_BORDER = Color(0xFFF5F5F5);
  static const Color LIGHT_BORDER_COLOR = Color(0xffE6E6E6);
  static const Color ALERT_COLOR = Color(0xffDBAB02);
  static const Color GOLD_COLOR = Color(0xffDBAB02);
  static const Color FAILED_COLOR = Colors.red;
  static const Color ERORR_COLOR = Color(0xFFFF4F65);
  static const Color RED_COLOR = Color(0xffFF3B30);
  static const Color HEADER = Color(0xFF1A1A1A);
  static const Color TITLE = Color(0xFF2B3449);
  static const Color BLACK = Color(0xFF151416);
  static const Color SUBTITLE = Color(0xff44506A);
  static const Color DETAILS_COLOR = Color(0xff999999);
  static const Color HINT_COLOR = Color(0xffB3B3B3);
  static const Color BORDER_COLOR = Color(0xffCCCCCC);

  // static const Color BORDER_COLOR = Color(0xffDFE2E8);

  static const Color SPLASH_BACKGROUND_COLOR = Color(0xffFFFFFF);
  static const List<Color> kBackgroundGradient = [
    Color(0xFF6C1410),
    Color(0xFFFE5953),
  ];


  static const List<Color> kAuthBackgroundGradient = [
    Color(0xFF6C1410),
    Color(0xFFFE5953),
  ];

  static const List<Color> kFloatMainButtonGradient = [
    Color(0xFF6C1410),
    Color(0xFFFE5953),
  ];

  static tripStatus(status) {
    if (status == "pending") {
      return DISABLED;
    } else if (status == "pay") {
      return PRIMARY_COLOR;
    } else if (status == "replay") {
      return PRIMARY_COLOR;
    } else {
      return WHITE_COLOR;
    }
  }
}
