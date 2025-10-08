class WarehouseModule {
  int? id;
  String? name;
  bool? isDefault;
  int? entityMode;

  WarehouseModule({this.id, this.name, this.isDefault, this.entityMode});

  WarehouseModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isDefault = json['isDefault'];
    entityMode = json['entityMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isDefault'] = this.isDefault;
    data['entityMode'] = this.entityMode;
    return data;
  }
}