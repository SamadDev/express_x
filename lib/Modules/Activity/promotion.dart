class PromotionModule {
  int? id;
  String? title;
  String? content;
  String? uri;
  String? creationDate;

  PromotionModule({this.id, this.title, this.content, this.uri, this.creationDate});

  PromotionModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    uri = json['uri'];
    creationDate = json['creation_date'];
  }

}