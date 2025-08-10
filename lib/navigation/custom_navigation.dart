import 'dart:io';
import 'package:aloo_lahma_admin/features/edit_profile/page/edit_profile_page.dart';
import 'package:aloo_lahma_admin/features/maps/models/location_model.dart';
import 'package:aloo_lahma_admin/features/order_details/page/order_details_page.dart';
import 'package:aloo_lahma_admin/features/setting/packages/about_us/view/about_the_app_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../app/services/analytics_service.dart';
import '../components/video_preview_page.dart';
import '../features/contact_with_us/page/contact_with_us_page.dart';
import '../features/faqs/page/faqs_page.dart';
import '../features/in_app_web_view/in_app_web_view_page.dart';
import '../features/maps/page/pick_map_page.dart';
import '../features/maps/page/preview_location_page.dart';
import '../features/notifications/page/notifications_page.dart';
import '../features/setting/packages/privacy_policy/view/privacy_policy.dart';
import '../features/setting/packages/terms_conditions/view/terms_conditions.dart';
import '../main.dart';
import 'routes.dart';
import '../main_page/page/dashboard.dart';
import '../features/profile/page/my_profile.dart';
import '../features/auth/forget_password/page/forget_password.dart';
import '../features/auth/login/page/login.dart';
import '../features/auth/reset_password/page/reset_password.dart';
import '../features/auth/verification/model/verification_model.dart';
import '../features/auth/verification/page/verification.dart';
import '../features/change_password/page/change_password_page.dart';

import '../features/splash/page/splash.dart';

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.app:
        return _pageRoute(const MyApp());
      case Routes.splash:
        return _pageRoute(const Splash());
      case Routes.login:
        return _pageRoute(Login());

      case Routes.forgetPassword:
        return _pageRoute(
            ForgetPassword(userType: settings.arguments as String));

      case Routes.resetPassword:
        return _pageRoute(ResetPassword(
          data: settings.arguments as VerificationModel,
        ));

      case Routes.changePassword:
        return _pageRoute(const ChangePasswordPage());

      case Routes.verification:
        return _pageRoute(
            Verification(model: settings.arguments as VerificationModel));

      case Routes.editProfile:
        return _pageRoute(EditProfilePage(
            fromComplete: (settings.arguments as bool?) ?? false));

      case Routes.profile:
        return _pageRoute(const MyProfile());

      case Routes.dashboard:
        return _pageRoute(DashBoard(
          index:
              settings.arguments != null ? (settings.arguments as int) : null,
        ));

      case Routes.notifications:
        return _pageRoute(const NotificationsPage());

      case Routes.orderDetails:
        return _pageRoute(OrderDetailsPage(id: settings.arguments as int));

      case Routes.videoPreview:
        return _pageRoute(VideoPreviewPage(data: settings.arguments as Map));

      case Routes.pickLocation:
        return _pageRoute(
            PickMapPage(data: settings.arguments as LocationModel));

      case Routes.previewLocation:
        return _pageRoute(
            PreviewLocationPage(location: settings.arguments as LocationModel));

      case Routes.inAppWebView:
        return _pageRoute(InAppViewPage(url: settings.arguments as String));

      case Routes.contactWithUs:
        return _pageRoute(const ContactWithUsPage());

      case Routes.privacy:
        return _pageRoute(const PrivacyPolicy());

      case Routes.terms:
        return _pageRoute(const TermsConditions());

      case Routes.aboutUs:
        return _pageRoute(const AboutTheAppPage());

      case Routes.faqs:
        return _pageRoute(const FaqsPage());

      default:
        return MaterialPageRoute(builder: (_) => const MyApp());
    }
  }

  static _pageRoute(Widget child) => Platform.isIOS
      ? CupertinoPageRoute(builder: (_) => child)
      : MaterialPageRoute(builder: (_) => child);

  // static PageRouteBuilder<dynamic> _pageRoute(Widget child) => PageRouteBuilder(
  //     transitionDuration: const Duration(milliseconds: 100),
  //     reverseTransitionDuration: const Duration(milliseconds: 100),
  //     transitionsBuilder: (c, anim, a2, child) {
  //       var begin = const Offset(1.0, 0.0);
  //       var end = Offset.zero;
  //       var tween = Tween(begin: begin, end: end);
  //       var curveAnimation =
  //           CurvedAnimation(parent: anim, curve: Curves.linearToEaseOut);
  //       return SlideTransition(
  //         position: tween.animate(curveAnimation),
  //         child: child,
  //       );
  //     },
  //     opaque: false,
  //     pageBuilder: (_, __, ___) => child);

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
        routeName,
            (route) => route.settings.name == Routes.dashboard,
        arguments: arguments,
      );
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return navigatorState.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}


class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView(PageRoute<dynamic> route) {
    final screenName = route.settings.name ?? route.runtimeType.toString();
    if (kDebugMode) {
      print("Navigated to $screenName");
    }
    // AnalyticsService.logScreen(screenName);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }
}

