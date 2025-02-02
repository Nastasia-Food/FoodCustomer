// ignore_for_file: unused_local_variable
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/data/model/body/notification_body.dart';
import 'app/modules/splash/bindings/splash_binding.dart';
import 'app/routes/app_pages.dart';
import 'helper/notification_helper.dart';
import 'translation/language.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final box = GetStorage();
dynamic langValue = const Locale('en', null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  NotificationBody? body;
  try {
    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      body = NotificationHelper.convertNotification(remoteMessage.data);
    }
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  } catch (e) {
    debugPrint(e.toString());
  }

  if (box.read('languageCode') != null) {
    langValue = Locale(box.read('languageCode'), null);
  } else {
    langValue = const Locale('en', null);
  }
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: ((context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Food Customer",
            translations: Languages(),
            theme: ThemeData(useMaterial3: false),
            locale: langValue,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            initialBinding: SplashBinding(),
          )),
    ),
  );
}
