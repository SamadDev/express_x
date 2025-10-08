import 'package:x_express/Utils/pagination.dart';

class NotificationListModule extends PaginatedData {
  late var id;
  var notificationTypeId;
  String? userId;
  String? dateTime;
  String? title;
  String? body;
  var isSeen;
  String? action;
  String? refId;

  NotificationListModule({
    required this.id,
    this.notificationTypeId,
    this.userId,
    this.dateTime,
    this.title,
    this.body,
    this.isSeen,
    this.action,
    this.refId,
  });

  NotificationListModule.fromJson(Map<String, dynamic> json) {
    notificationTypeId = json['notificationTypeId'];
    userId = json['userId'];
    dateTime = json['dateTime'];
    title = json['title'];
    body = json['body'];
    isSeen = json['isSeen'];
    action = json['action'];
    refId = json['refId'];
  }
}
