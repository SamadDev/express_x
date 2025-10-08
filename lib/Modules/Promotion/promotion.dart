class promotionModel {
  int? id;
  String? title;
  String? description;
  String? attachment;
  int? isActive;
  int? count;
  String? createdAt;
  String? updatedAt;

  promotionModel({
    this.id,
    this.title,
    this.attachment,
    this.isActive,
    this.count,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  promotionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    attachment = json['attachment'];
    description = json['description'];
    isActive = json['is_active'];
    count = json['count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}