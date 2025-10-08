import 'package:flutter/material.dart';
import 'package:x_express/Utils/exports.dart';

class NotificationService with ChangeNotifier {

  Future<void> setNotification({n_id}) async {
    notifyListeners();
  }
}
