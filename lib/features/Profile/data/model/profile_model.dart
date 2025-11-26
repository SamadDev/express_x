class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? imageUrl;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.imageUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return ProfileModel(
      id: data['id']?.toString() ?? '',
      name: data['name']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      phoneNumber: data['phone_number']?.toString() ?? '',
      imageUrl: data['image_url']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'image_url': imageUrl,
    };
  }

  // Get initials from name
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return '??';
  }
}


