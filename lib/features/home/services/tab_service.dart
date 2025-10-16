import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:x_express/core/config/constant/api.dart';

class Tab {
  final String name;
  final String id;
  final String? description;

  Tab({
    required this.name,
    required this.id,
    this.description,
  });

  factory Tab.fromJson(Map<String, dynamic> json) {
    return Tab(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      description: json['description'],
    );
  }
}

class TabService {
  static Future<List<Tab>> fetchTabs() async {
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.baseURL}tabs'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Tab.fromJson(json)).toList();
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

  static List<Tab> _getDefaultTabs() {
    return [
      Tab(name: 'US-A', id: 'us-a'),
      Tab(name: 'Dubai', id: 'dubai'),
      Tab(name: 'Turkey', id: 'turkey'),
      Tab(name: 'Canada', id: 'canada'),
      Tab(name: 'UK', id: 'uk'),
    ];
  }
}
