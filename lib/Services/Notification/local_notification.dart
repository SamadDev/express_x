// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class LocalNotificationApi {
//   factory LocalNotificationApi() {
//     return _singleton;
//   }
//
//   LocalNotificationApi._internal();
//
//   static final LocalNotificationApi _singleton = LocalNotificationApi._internal();
//
//   late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   bool initialize = false;
//
//   Future<void> init() async {
//     if (initialize) return;
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     const android = AndroidInitializationSettings('app_icon');
//
//     const channel = AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       description: 'This channel is used for important notifications.',
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('eagle'),
//       enableVibration: true,
//       importance: Importance.max,
//     );
//     const iOS = IOSInitializationSettings(
//       defaultPresentAlert: false,
//       defaultPresentBadge: false,
//       defaultPresentSound: false,
//     );
//
//     // await flutterLocalNotificationsPlugin
//     //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//     //     ?.createNotificationChannel(channel);
//
//     const initSettings = InitializationSettings(android: android, iOS: iOS);
//
//     await flutterLocalNotificationsPlugin.initialize(
//       initSettings,
//       onSelectNotification: _onSelectNotification,
//     );
//     initialize = true;
//   }
//
//   Future _onSelectNotification(String? json) async {
//     onTap?.call();
//   }
//
//   VoidCallback? onTap;
//
//   Future<void> showNotification(Map<String, dynamic> data, VoidCallback onTap) async {
//     print("__________________function______________________");
//     this.onTap = onTap;
//
//     const android = AndroidNotificationDetails(
//       'high_importance_channel',
//       'channel name',
//       channelDescription: 'channel description',
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('eagle'),
//       enableVibration: true,
//       priority: Priority.high,
//       importance: Importance.max,
//     );
//     const iOS = IOSNotificationDetails(
//       sound: 'eagle.wav',
//       presentSound: true,
//       presentAlert: true,
//       presentBadge: true,
//
//     );
//     const platform = NotificationDetails(android: android, iOS: iOS);
//     final json = jsonEncode(data);
//
//     await flutterLocalNotificationsPlugin.show(
//       0, // notification id
//       data['title'] as String,
//       data['body'] as String,
//       platform,
//       payload: json,
//     );
//   }
// }