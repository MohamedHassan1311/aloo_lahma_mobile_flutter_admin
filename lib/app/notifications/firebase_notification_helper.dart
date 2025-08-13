part of 'notification_helper.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('on Message background notification ${message.data}');
  log('on Message background data ${message.notification?.body}');
  log("Handling a background message: ${message.notification!.toMap()}");

  scheduleNotification(
    message.notification?.title ?? "",
    message.notification?.body ?? "",
    json.encode(message.data),
    imageUrl: message.data['image']?.toString(),
  );

  handlePath(message.data);
}

FirebaseMessaging? _firebaseMessaging;

class FirebaseNotifications {
  static FirebaseNotifications? _instance;

  FirebaseNotifications._internal();

  factory FirebaseNotifications() {
    _instance ??= FirebaseNotifications._internal();
    return _instance!;
  }

  static Future<void> setUpFirebase() async {
    // Background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging!.setAutoInitEnabled(true);

    // ✅ Ensure notifications show when app is in foreground (iOS)
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await localNotification(); // Your local notifications init

    await firebaseCloudMessagingListeners();
  }

  static Future<void> firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) {
      iOSPermission(); // Request iOS permissions
    }

    // Foreground messages
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage data) {
        log('on Message notification ${data.notification?.toMap()}');
        log('on Message data ${data.data}');
        log('on Message body ${data.notification?.body}');
        Map notify = data.data;
        log("$notify");

        // ✅ Always schedule a local notification so user sees it in foreground
        scheduleNotification(
          data.notification?.title ?? "",
          data.notification?.body ?? "",
          json.encode(notify),
          imageUrl: notify['image']?.toString(),
        );

        updateUserFunctions(notify: notify);
      },
    );

    // When app is opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage data) {
      log('on Opened ${data.data}');
      handlePath(data.data);
    });

    // App launch from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        log("Data from initial message >>>>>> ${value.data}");
        handlePath(value.data);
      }
    });

    // Local notifications tapped while app running
    _notificationsPlugin!.getActiveNotifications().then((value) {
      if (value.isNotEmpty) {
        log('on Opened From ActiveNotifications ${value[0].payload}');
        if (value[0].payload?.isNotEmpty ?? false) {
          handlePath(json.decode(value[0].payload!));
        }
      }
    });

    // App launched via local notification
    _notificationsPlugin!
        .getNotificationAppLaunchDetails()
        .then((NotificationAppLaunchDetails? data) {
      if (data?.notificationResponse?.payload?.isNotEmpty ?? false) {
        log('on Opened From Notification ${data!.notificationResponse!.payload}');
        handlePath(json.decode(data.notificationResponse!.payload!));
      }
    });
  }
}
