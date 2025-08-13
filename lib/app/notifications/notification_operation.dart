part of 'notification_helper.dart';

scheduleNotification(String title, String subtitle, String data,
    {String? imageUrl}) async {
  var rng = math.Random();

  AndroidNotificationDetails androidPlatformChannelSpecifics;
  DarwinNotificationDetails iOSPlatformChannelSpecifics;

  String? imagePath;
  if (imageUrl != null && imageUrl.isNotEmpty) {
    try {
      final fileName = _deriveFileNameFromUrl(imageUrl);
      imagePath = await _downloadAndSaveImage(imageUrl, fileName);
    } catch (e) {
      log('Image download failed: $e');
    }
  }

  if (imagePath != null) {
    // Android Big Picture style
    final bigPicture = FilePathAndroidBitmap(imagePath);
    final styleInfo = BigPictureStyleInformation(
      bigPicture,
      hideExpandedLargeIcon: true,
      contentTitle: title,
      summaryText: subtitle,
    );
    androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'your channel name',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
      styleInformation: styleInfo,
    );

    // iOS attachment
    iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      attachments: [
        DarwinNotificationAttachment(imagePath),
      ],
    );
  } else {
    androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'your channel name',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );
    iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
  }

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await _notificationsPlugin!.show(
    rng.nextInt(100000),
    title,
    subtitle,
    platformChannelSpecifics,
    payload: data,
  );
}

String _deriveFileNameFromUrl(String url) {
  final uri = Uri.parse(url);
  String name =
      uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'image.jpg';
  if (!name.contains('.')) {
    name = '$name.jpg';
  }
  // Add some randomness to avoid collisions
  return '${DateTime.now().millisecondsSinceEpoch}_${math.Random().nextInt(10000)}_${name}';
}

Future<String> _downloadAndSaveImage(String url, String fileName) async {
  final httpClient = HttpClient();
  final request = await httpClient.getUrl(Uri.parse(url));
  final response = await request.close();

  if (response.statusCode != 200) {
    throw HttpException('Failed to download image: ${response.statusCode}');
  }

  final bytes = <int>[];
  await for (final data in response) {
    bytes.addAll(data);
  }

  final directory = Directory.systemTemp;
  final file = File('${directory.path}/$fileName');
  await file.writeAsBytes(bytes);
  return file.path;
}

void iOSPermission() {
  _firebaseMessaging!.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

void handlePath(Map dataMap) {
  updateUserFunctions(notify: dataMap);
  handlePathByRoute(dataMap);
}

updateUserFunctions({required notify}) async {
  /*Future.delayed(Duration.zero, () {
    if (UserBloc.instance.isLogin) {
      // sl<NotificationsBloc>().add(Get(arguments: SearchEngine()));
    }
  });*/
}

Future<void> handlePathByRoute(Map notify) async {
  Future.delayed(
    Duration.zero,
    () {
      CustomNavigator.push(Routes.notifications);
    },
  );
}
