class ShipmentSatesModule {
  var id;
  var title;
  var titleKr;
  var titleAr;
  bool? check;

  ShipmentSatesModule({this.id, this.title, this.titleAr, this.titleKr, this.check});

  ShipmentSatesModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['name'];
    titleAr = json['nameAR'];
    titleKr = json['nameKU'];
    check = json['check'];
  }
}
