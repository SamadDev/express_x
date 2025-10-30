import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:x_express/core/config/network/network.dart';
import 'package:x_express/core/config/constant/api.dart';
import 'package:x_express/features/home/models/order_model.dart';
import 'package:x_express/features/Auth/data/repository/local_storage.dart';

class OrderApiService {
  static const String _ordersEndpoint = 'orders';
  
  /// Fetch user's order history
  static Future<OrderHistoryResponse> getOrderHistory({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };
      
      if (status != null && status.isNotEmpty && status.toLowerCase() != 'all') {
        queryParams['status'] = status;
      }

      // Make real API call
      final response = await Request.get(
        '$_ordersEndpoint',
        queryParameters: queryParams,
      );

      // Parse the API response structure
      if (response != null && response['data'] != null) {
        final List<dynamic> ordersData = response['data'] as List<dynamic>;
        final orders = ordersData.map((orderJson) => Order.fromJson(orderJson)).toList();
        
        return OrderHistoryResponse(
          orders: orders,
          totalCount: response['total_count'] ?? orders.length,
          currentPage: response['current_page'] ?? page,
          totalPages: response['total_pages'] ?? 1,
        );
      } else {
        // Fallback to mock data if API fails
        return await _getMockOrderHistory(page: page, limit: limit, status: status);
      }
    } catch (e) {
      print('Error fetching order history from API: $e');
      // Fallback to mock data
      return await _getMockOrderHistory(page: page, limit: limit, status: status);
    }
  }

  /// Fallback method to get mock order history
  static Future<OrderHistoryResponse> _getMockOrderHistory({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Load mock data from JSON asset
      final String response = await rootBundle.loadString('assets/mock_orders.json');
      final data = json.decode(response) as List;

      // Filter by status if provided
      List<dynamic> filteredData = data;
      if (status != null && status.isNotEmpty && status.toLowerCase() != 'all') {
        filteredData = data.where((order) => 
          order['status'].toString().toLowerCase() == status.toLowerCase()
        ).toList();
      }

      // Simulate pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      final paginatedData = filteredData.sublist(
        startIndex, 
        endIndex.clamp(0, filteredData.length)
      );

      final orders = paginatedData.map((json) => Order.fromJson(json)).toList();
      
      return OrderHistoryResponse(
        orders: orders,
        totalCount: filteredData.length,
        currentPage: page,
        totalPages: (filteredData.length / limit).ceil(),
      );
    } catch (e) {
      print('Error fetching mock order history: $e');
      return OrderHistoryResponse(
        orders: [],
        totalCount: 0,
        currentPage: 1,
        totalPages: 1,
      );
    }
  }

  /// Get a specific order by ID
  static Future<Order?> getOrderById(String orderId) async {
    try {
      final response = await Request.get('$_ordersEndpoint/$orderId');
      
      if (response != null && response['order'] != null) {
        return Order.fromJson(response['order']);
      }
      return null;
    } catch (e) {
      print('Error fetching order by ID: $e');
      return null;
    }
  }

  /// Create a new order
  static Future<Order?> createOrder({
    required String productName,
    required String storeName,
    required double price,
    String? description,
    String? imageUrl,
  }) async {
    try {
      // Debug: Check if user is authenticated
      final token = await LocalStorage.getToken();
      print('🔐 Auth token available: ${token != null && token.isNotEmpty}');
      
      // Use the correct API endpoint for creating orders with form data
      final orderData = {
        'items[0][store_id]': '1', // Default store ID
        'items[0][product_name]': productName,
        'items[0][link]': 'https://example.com', // Default link
        'items[0][product_price]': price.toString(),
        'items[0][quantity]': '1',
        'items[0][color]': 'default',
        'items[0][size]': 'default',
        'items[0][note]': description ?? '',
      };

      print('📦 Order data: $orderData');
      
      // Use form data instead of JSON for the order endpoint
      final response = await Request.post('order', orderData, forceFormData: true);
      
      print('📥 Order API response: $response');
      
      if (response != null) {
        // Handle different response formats
        if (response['order'] != null) {
          return Order.fromJson(response['order']);
        } else if (response['data'] != null) {
          return Order.fromJson(response['data']);
        } else {
          // Create a mock order if API doesn't return proper data
          print('⚠️ API response doesn\'t contain order data, creating mock order');
          return Order(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            productName: productName,
            storeName: storeName,
            price: price,
            orderDate: DateTime.now(),
            status: 'pending',
            description: description,
            imageUrl: imageUrl,
          );
        }
      }
      return null;
    } catch (e) {
      print('❌ Error creating order: $e');
      
      // Check if it's a 302 redirect error
      if (e.toString().contains('302')) {
        print('🔄 API returned 302 redirect - this might indicate:');
        print('   1. Authentication issue (token expired or invalid)');
        print('   2. API endpoint not found or moved');
        print('   3. Server configuration issue');
        print('   Creating mock order as fallback...');
      }
      
      // Return a mock order on API failure
      return Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productName: productName,
        storeName: storeName,
        price: price,
        orderDate: DateTime.now(),
        status: 'pending',
        description: description,
        imageUrl: imageUrl,
      );
    }
  }

  /// Update order status
  static Future<bool> updateOrderStatus(String orderId, String status) async {
    try {
      final updateData = {
        'status': status,
      };

      await Request.put('$_ordersEndpoint/$orderId/status', updateData);
      return true;
    } catch (e) {
      print('Error updating order status: $e');
      return false;
    }
  }

  /// Cancel an order
  static Future<bool> cancelOrder(String orderId) async {
    try {
      await Request.put('$_ordersEndpoint/$orderId/cancel', {});
      return true;
    } catch (e) {
      print('Error canceling order: $e');
      return false;
    }
  }

  /// Get order statistics
  static Future<Map<String, dynamic>?> getOrderStats() async {
    try {
      final response = await Request.get('$_ordersEndpoint/stats');
      return response;
    } catch (e) {
      print('Error fetching order stats: $e');
      return null;
    }
  }

  /// Get order statuses from API
  static Future<List<Map<String, dynamic>>> getOrderStatuses() async {
    try {
      final response = await Request.get('order-statuses');
      
      if (response != null && response['data'] != null) {
        final List<dynamic> statusesData = response['data'] as List<dynamic>;
        return statusesData.map((status) => {
          'id': status['id'],
          'name': status['name'],
          'color': status['color'],
        }).toList();
      }
      
      // Fallback to default statuses
      return [
        {'id': '1', 'name': 'pending', 'color': '#f0ad4e'},
        {'id': '2', 'name': 'processing', 'color': '#007bff'},
        {'id': '3', 'name': 'completed', 'color': '#28a745'},
        {'id': '4', 'name': 'cancelled', 'color': '#dc3545'},
        {'id': '5', 'name': 'rejected', 'color': '#dc3545'},
      ];
    } catch (e) {
      print('Error fetching order statuses: $e');
      // Return default statuses on error
      return [
        {'id': '1', 'name': 'pending', 'color': '#f0ad4e'},
        {'id': '2', 'name': 'processing', 'color': '#007bff'},
        {'id': '3', 'name': 'completed', 'color': '#28a745'},
        {'id': '4', 'name': 'cancelled', 'color': '#dc3545'},
        {'id': '5', 'name': 'rejected', 'color': '#dc3545'},
      ];
    }
  }
}
