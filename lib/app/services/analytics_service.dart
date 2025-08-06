import 'dart:developer';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final FirebaseAnalytics _firebase = FirebaseAnalytics.instance;

  /// Initialize analytics, push token and WebEngage
  static Future<void> init() async {
    if (Platform.isIOS) {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    }
  }

  /// Log custom event
  static Future<void> logEvent(String name,
      [Map<String, dynamic>? parameters]) async {
    if (kDebugMode) log("logEvent $name ${parameters.toString()}");

    final firebaseParams = parameters == null
        ? null
        : Map.fromEntries(
            parameters.entries
                .where((e) => e.value != null)
                .map((e) => MapEntry(e.key, e.value as Object)),
          );

    await _firebase.logEvent(name: name, parameters: firebaseParams);
  }
}
