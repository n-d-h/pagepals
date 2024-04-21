import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/providers/notification_provider.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/notification_service.dart';
import 'package:provider/provider.dart';

class FirebaseMessageService {
  final BuildContext? context;

  FirebaseMessageService({this.context});

  Future<void> initialize() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        sendNotification(title: notification.title, body: notification.body);
        if (context != null){
          context!.read<NotificationProvider>().increment();
          // var accountModel = await AuthenService.getAccountFromSharedPreferences();
          // var result = await NotificationService.getAllNotificationByAccountId(
          //     accountModel?.id ?? "", 0, 10);
          // context!.read<NotificationProvider>().setCount(result.total ?? 0);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        sendNotification(title: notification.title, body: notification.body);
        print('onMessageOpenedApp: $message');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("onBackgroundMessage: $message");
  }

  Future<String?> getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  void sendNotification({String? title, String? body}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_channel', 'High Importance Notification',
        description: "This channel is for important notification",
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      color: Colors.blue,
      ledColor: Colors.blue,
      ledOnMs: 1000,
      ledOffMs: 500,
    );

    flutterLocalNotificationsPlugin.show(
      Random().nextInt(100),
      title,
      body,
      NotificationDetails(
        android: androidNotificationDetails,
      ),
      payload: 'high importance',
    );
  }
}
