class PaymentMethod {
  final String id;
  final String name;
  final String? description;
  final String? icon;

  PaymentMethod({
    required this.id,
    required this.name,
    this.description,
    this.icon,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      icon: json['icon']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
    };
  }
}


