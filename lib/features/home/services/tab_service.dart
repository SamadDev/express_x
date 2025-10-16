import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:x_express/core/config/constant/api.dart';

class Store {
  final String id;
  final String name;
  final String image;
  final String websiteUrl;

  Store({
    required this.id,
    required this.name,
    required this.image,
    required this.websiteUrl,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      websiteUrl: json['website_url'] ?? '',
    );
  }
}

class TabItem {
  final String name;
  final String id;
  final List<Store> stores;

  TabItem({
    required this.name,
    required this.id,
    required this.stores,
  });

  factory TabItem.fromJson(Map<String, dynamic> json) {
    return TabItem(
      name: json['name'] ?? '',
      id: json['id']?.toString() ?? '',
      stores: (json['stores'] as List<dynamic>?)
          ?.map((storeJson) => Store.fromJson(storeJson))
          .toList() ?? [],
    );
  }
}

class TabService {
  static Future<List<TabItem>> fetchTabs() async {
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.baseURL}stores'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'] ?? [];
        return data.map((json) => TabItem.fromJson(json)).toList();
      } else {
        // Return default tabs if API fails
        return _getDefaultTabs();
      }
    } catch (e) {
      print('Error fetching tabs: $e');
      // Return default tabs if API fails
      return _getDefaultTabs();
    }
  }

  static List<TabItem> _getDefaultTabs() {
    return [
      TabItem(
        name: 'USA',
        id: '2',
        stores: [
          Store(
            id: '1',
            name: 'Amazon',
            image: 'amazon.png',
            websiteUrl: 'https://www.amazon.com',
          ),
          Store(
            id: '2',
            name: 'eBay',
            image: 'ebay.png',
            websiteUrl: 'https://www.ebay.com',
          ),
        ],
      ),
      TabItem(
        name: 'China',
        id: '3',
        stores: [
          Store(
            id: '4',
            name: 'AliExpress',
            image: 'aliexpress.png',
            websiteUrl: 'https://www.aliexpress.com',
          ),
        ],
      ),
    ];
  }
}
