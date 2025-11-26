import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:x_express/core/config/constant/api.dart';

class Warehouse {
  final String id;
  final String name;
  final String addressLine1;
  final String addressLine2;
  final String phoneNumber;
  final String email;
  final String postalCode;
  final String street;
  final String country;
  final String city;
  final String image; // Default to "china flat"

  Warehouse({
    required this.id,
    required this.name,
    required this.addressLine1,
    required this.addressLine2,
    required this.phoneNumber,
    required this.email,
    required this.postalCode,
    required this.street,
    required this.country,
    required this.city,
    this.image = 'china_flat.png', // Default image
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      addressLine1: json['address_line_1'] ?? '',
      addressLine2: json['address_line_2'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      postalCode: json['postal_code'] ?? '',
      street: json['street'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      image: 'china_flat.png', // Default image as per user request
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'phone_number': phoneNumber,
      'email': email,
      'postal_code': postalCode,
      'street': street,
      'country': country,
      'city': city,
    };
  }

  // Full address string
  String get fullAddress {
    final parts = [
      addressLine1,
      addressLine2,
      street,
      city,
      postalCode,
      country,
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(', ');
  }
}

class WarehouseService {
  static Future<List<Warehouse>> fetchWarehouses() async {
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.baseURL}warehouses'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'] ?? [];
        return data.map((json) => Warehouse.fromJson(json)).toList();
      } else {
        print('API Error: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetching warehouses: $e');
      return [];
    }
  }

  static Future<Warehouse?> fetchWarehouseDetail(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.baseURL}warehouse/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic>? data = responseData['data'];
        if (data != null) {
          return Warehouse.fromJson(data);
        }
      } else {
        print('API Error: ${response.statusCode} - ${response.body}');
      }
      return null;
    } catch (e) {
      print('Error fetching warehouse detail: $e');
      return null;
    }
  }
}
