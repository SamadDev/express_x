// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationListService with ChangeNotifier {
  List<NotificationListModule> _notificationList = [];
  List<NotificationListModule> get notificationList => _notificationList;
  String status = '';

  Future<List<NotificationListModule>> getNotificationList({required int page, required BuildContext context, type}) async {
    try {
      print("page is: $page");
      var data = await Request.reqGet('shared/notifications/user-notifications?pageNumber=$page&pageSize=10');
      if (data['status'] == 'false') return [];
      List<NotificationListModule> newPending = data.map<NotificationListModule>((e) => NotificationListModule.fromJson(e)).toList();
      return newPending;
    } catch (e) {
      print("error pending is: $e");
      return [];
    }
  }

  bool notification_permission = true;

  Future<void> setNotificationPermission(value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('notification_permission', value);
    notification_permission = value;
    notifyListeners();
  }

  Future<void> getNotificationPermission() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    notification_permission = await preferences.getBool('notification_permission')!;
    notifyListeners();
  }

  // void notificationPermission() async {
  //   if (notification_permission) {
  //     FirebaseMessaging.instance.unsubscribeFromTopic('brandcity');
  //     print('if notification permission is true');
  //   } else {
  //     FirebaseMessaging.instance.unsubscribeFromTopic('brandcity');
  //     print('if notification permission is false');
  //   }
  // }
}
