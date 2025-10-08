class AgreementUploadModel {
  int attachmentTypeId;
  DateTime dateTime;
  String fileUrl;
  String refId;

  AgreementUploadModel({
    required this.attachmentTypeId,
    required this.dateTime,
    required this.fileUrl,
    required this.refId,
  });

  Map<String, dynamic> toMap() {
    return {
      'attachmentTypeId': attachmentTypeId,
      'dateTime': dateTime.toIso8601String(),
      'fileUrl': fileUrl,
      'refId': refId,
    };
  }
}

class AccountCustomerInfo {
  var id;
  var statusId;
  var accountId;
  var uniqueId;
  var entityMode;
  var code;

  AccountCustomerInfo({this.id, this.statusId, this.accountId, this.uniqueId, this.entityMode, this.code});

  AccountCustomerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusId = json['statusId'];
    accountId = json['accountId'];
    uniqueId = json['uniqueId'];
    code = json['code'];
    entityMode = json['entityMode'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'statusId': statusId,
      'accountId': accountId,
      'uniqueId': uniqueId,
      'code': code,
      'entityMode': entityMode
    };
  }
}
