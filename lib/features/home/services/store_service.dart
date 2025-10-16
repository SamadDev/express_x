import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:x_express/core/config/constant/api.dart';

class Store {
  final String name;
  final String url;
  final String image;
  final String description;
  final String baseUrl;

  Store({
    required this.name,
    required this.url,
    required this.image,
    required this.description,
    required this.baseUrl,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? 'amazon.png', // Default image
      description: json['description'] ?? '',
      baseUrl: json['base_url'] ?? json['url'] ?? '',
    );
  }
}

class StoreService {
  static Future<List<Store>> fetchStores() async {
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.baseURL}stores'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Store.fromJson(json)).toList();
      } else {
        // Return default stores if API fails
        return _getDefaultStores();
      }
    } catch (e) {
      print('Error fetching stores: $e');
      // Return default stores if API fails
      return _getDefaultStores();
    }
  }

  static List<Store> _getDefaultStores() {
    return [
      Store(
        name: 'Amazon',
        url: 'https://www.amazon.com',
        image: 'amazon.png',
        description: 'Everything you need',
        baseUrl: 'https://www.amazon.com',
      ),
      Store(
        name: 'eBay',
        url: 'https://www.ebay.com',
        image: 'ebay.png',
        description: 'Buy and sell anything',
        baseUrl: 'https://www.ebay.com',
      ),
      Store(
        name: 'Zara',
        url: 'https://www.zara.com',
        image: 'zara.png',
        description: 'Fashion and clothing',
        baseUrl: 'https://www.zara.com',
      ),
    ];
  }
}
