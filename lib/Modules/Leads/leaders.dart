class LeadersModel {
  final int id;
  final String nameEn;
  final String nameAr;
  final String phone;
  final String? phoneTwo;
  final String email;
  final String address;
  final String? description;
  final String? proficiency;

  LeadersModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.phone,
    this.phoneTwo,
    required this.email,
    required this.address,
    this.description,
    this.proficiency,
  });

  factory LeadersModel.fromJson(Map<String, dynamic> json) {
    return LeadersModel(
      id: json['id'] ?? 0,
      nameEn: json['nameEn'] ?? '',
      nameAr: json['nameAr'] ?? '',
      phone: json['phone'] ?? '',
      phoneTwo: json['phoneTwo'],
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      description: json['description'],
      proficiency: json['proficiency'],
    );
  }
}
