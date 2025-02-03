// ignore_for_file: empty_catches, unnecessary_new, prefer_const_constructors, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages, unnecessary_null_comparison, avoid_print, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../app/data/model/body/notification_body.dart';
import '../app/data/model/body/payload_model.dart';
import '../app/modules/order/controllers/order_controller.dart';
import '../app/modules/order/views/order_view.dart';

class NotificationHelper {
  void notificationPermission() async {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted provisional permission");
    } else {
      debugPrint("User denied permission");
    }
  }

  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = new DarwinInitializationSettings();
    var initializationsSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (payload) async {
      try {
        if (payload.payload != null && payload.payload != '') {
          PayLoadBody payLoadBody =
              PayLoadBody.fromJson(jsonDecode(payload.payload!));
          if (payLoadBody.topicName == 'Order Notification') {
            Get.to(() => OrderView());
          }
        }
      } catch (e) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, false);
      var orderController = Get.put(OrderController());

      orderController.orderNotificationId.value =
          message.data["order_id"].toString();
      if (message.data["order_id"].toString() == "") {
        orderController.orderNotfyLoader.value = false;
      } else {
        orderController.orderNotfyLoader.value = true;
      }

      try {
        if (message != null && message.data.isNotEmpty) {
          NotificationBody _notificationBody =
              convertNotification(message.data);

          if (_notificationBody.topic == 'Order Notification') {
            Get.to(() => OrderView());
          }
        }
      } catch (e) {
        print(e.toString());
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      try {
        if (message != null && message.data.isNotEmpty) {
          NotificationBody _notificationBody =
              convertNotification(message.data);
          if (_notificationBody.topic == 'general') {
            Get.to(() => OrderView());
          }
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    if (!GetPlatform.isIOS) {
      String? _title;
      String? _body;
      String? _image;
      String playLoad = jsonEncode(message.data);
      if (data) {
        _title = message.data['title'];
        _body = message.data['body'];
        _image =
            (message.data['image'] != null && message.data['image'].isNotEmpty)
                ? message.data['image']
                : null;
      } else {
        _title = message.notification!.title;
        _body = message.notification!.body;
        _image =
            (message.data['image'] != null && message.data['image'].isNotEmpty)
                ? message.data['image']
                : null;
        if (GetPlatform.isAndroid) {
          _image = (message.notification!.android!.imageUrl != null &&
                  message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl!.startsWith('http')
                  ? message.notification!.android!.imageUrl
                  : message.data['image']
              : null;
        } else if (GetPlatform.isIOS) {
          _image = (message.notification!.apple!.imageUrl != null &&
                  message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl!.startsWith('http')
                  ? message.notification!.apple!.imageUrl
                  : message.data['image']
              : null;
        }
      }

      if (_image != null && _image.isNotEmpty) {
        try {
          await showBigPictureNotificationHiddenLargeIcon(
              _title!, _body!, playLoad, _image, fln);
        } catch (e) {
          await showBigTextNotification(_title!, _body!, playLoad, '', fln);
        }
      } else {
        await showBigTextNotification(_title!, _body!, playLoad, '', fln);
      }
    }
  }

  static Future<void> showBigTextNotification(String title, String body,
      String payload, String image, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      Random.secure().nextInt(10000).toString(),
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.max,
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(1, title, body, platformChannelSpecifics, payload: payload);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String title,
      String body,
      String payload,
      String image,
      FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      Random.secure().nextInt(10000).toString(),
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.max,
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      styleInformation: bigPictureStyleInformation,
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(1, title, body, platformChannelSpecifics, payload: payload);
  }

  static NotificationBody convertNotification(Map<String, dynamic> data) {
    return NotificationBody.fromJson(data);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  // var androidInitialize =
  //     new AndroidInitializationSettings('notification_icon');
  // var iOSInitialize = new DarwinInitializationSettings();
  // var initializationsSettings = new InitializationSettings(
  //     android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(
  //     message, flutterLocalNotificationsPlugin, true);
}
