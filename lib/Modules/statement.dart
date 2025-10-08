class SatesModule {
  var id;
  var title;
  var titleKr;
  var titleAr;
  bool? check;

  SatesModule({this.id, this.title, this.check,this.titleAr,this.titleKr});

  SatesModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleKr=json['nameKU'];
    titleAr=json['nameAR'];
    title = json['name'];
    check = json['check'];
  }
}