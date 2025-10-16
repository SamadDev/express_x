import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:x_express/core/config/constant/api.dart';

class TabItem {
  final String name;
  final String id;
  final String? description;

  TabItem({
    required this.name,
    required this.id,
    this.description,
  });

  factory TabItem.fromJson(Map<String, dynamic> json) {
    return TabItem(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      description: json['description'],
    );
  }
}

class TabService {
  static Future<List<TabItem>> fetchTabs() async {
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.baseURL}tabs'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
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
      TabItem(name: 'US-A', id: 'us-a'),
      TabItem(name: 'Dubai', id: 'dubai'),
      TabItem(name: 'Turkey', id: 'turkey'),
      TabItem(name: 'Canada', id: 'canada'),
      TabItem(name: 'UK', id: 'uk'),
    ];
  }
}
