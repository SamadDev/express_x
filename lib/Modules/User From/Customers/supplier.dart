class SupplierModule {
  int? id;
  String? code;
  String? name;
  int? statusId;
  int? accountId;
  int? entityMode;

  SupplierModule(
      {this.id,
        this.code,
        this.name,
        this.statusId,
        this.accountId,
        this.entityMode});

  SupplierModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    statusId = json['statusId'];
    accountId = json['accountId'];
    entityMode = json['entityMode'];
  }

}