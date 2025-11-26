import 'dart:io';
import 'package:flutter/material.dart';
import 'package:x_express/features/Home/data/model/order_model.dart';
import 'package:x_express/features/Home/data/service/order_api_service.dart';
import 'package:x_express/features/Bag/data/service/bag_service.dart';

class OrderService extends ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalCount = 0;
  String _selectedStatus = 'all';
  List<Map<String, dynamic>> _orderStatuses = [];

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalCount => _totalCount;
  bool get hasMorePages => _currentPage < _totalPages;
  String get selectedStatus => _selectedStatus;
  List<Map<String, dynamic>> get orderStatuses => _orderStatuses;

  /// Load order history from API
  Future<void> loadOrderHistory({bool refresh = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (refresh) {
        _currentPage = 1;
        _orders.clear();
      }

      final response = await OrderApiService.getOrderHistory(
        page: _currentPage,
        limit: 20,
        status: _selectedStatus == 'all' ? null : _selectedStatus,
      );

      if (refresh) {
        _orders = response.orders;
      } else {
        _orders.addAll(response.orders);
      }

      _currentPage = response.currentPage;
      _totalPages = response.totalPages;
      _totalCount = response.totalCount;
    } catch (e) {
      _error = e.toString();
      print('Error loading order history: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load more orders (pagination)
  Future<void> loadMoreOrders() async {
    if (_isLoading || !hasMorePages) return;

    _currentPage++;
    await loadOrderHistory();
  }

  /// Create a new order
  Future<Order?> createOrder({
    required String productName,
    required String storeName,
    required double price,
    String? description,
    String? imageUrl,
    String? storeId,
    String? link,
    int quantity = 1,
    String? color,
    String? size,
    File? imageFile,
  }) async {
    try {
      final order = await OrderApiService.createOrder(
        productName: productName,
        storeName: storeName,
        price: price,
        description: description,
        imageUrl: imageUrl,
        storeId: storeId,
        link: link,
        quantity: quantity,
        color: color,
        size: size,
        imageFile: imageFile,
      );

      if (order != null) {
        _orders.insert(0, order);
        _totalCount++;
        notifyListeners();
      }

      return order;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  /// Create order from bag items
  Future<Order?> createOrderFromBagItems(List<BagItem> items) async {
    try {
      print(
          '🔄 OrderService: Starting createOrderFromBagItems for ${items.length} items');
      final order = await OrderApiService.createOrderFromBagItems(items);
      print('🔄 OrderService: Received order from API: ${order != null}');

      if (order != null) {
        _orders.insert(0, order); // Add to beginning of list
        _totalCount++;
        notifyListeners();
        print(
            '🔄 OrderService: Added order to list, total orders: ${_orders.length}');
      }

      return order;
    } catch (e) {
      print('❌ OrderService: Error: $e');
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  /// Update order status
  Future<bool> updateOrderStatus(String orderId, String status) async {
    try {
      final success = await OrderApiService.updateOrderStatus(orderId, status);

      if (success) {
        // Update local order
        final index = _orders.indexWhere((order) => order.id == orderId);
        if (index != -1) {
          _orders[index] = Order(
            id: _orders[index].id,
            productName: _orders[index].productName,
            storeName: _orders[index].storeName,
            status: status,
            price: _orders[index].price,
            orderDate: _orders[index].orderDate,
            imageUrl: _orders[index].imageUrl,
            description: _orders[index].description,
          );
          notifyListeners();
        }
      }

      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Cancel an order
  Future<bool> cancelOrder(String orderId) async {
    try {
      final success = await OrderApiService.cancelOrder(orderId);

      if (success) {
        await updateOrderStatus(orderId, 'cancelled');
      }

      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Get order by ID
  Future<Order?> getOrderById(String orderId) async {
    try {
      return await OrderApiService.getOrderById(orderId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  /// Get order statistics
  Future<Map<String, dynamic>?> getOrderStats() async {
    try {
      return await OrderApiService.getOrderStats();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Refresh orders
  Future<void> refreshOrders() async {
    await loadOrderHistory(refresh: true);
  }

  /// Change status filter
  Future<void> changeStatusFilter(String status) async {
    if (_selectedStatus == status) return;

    _selectedStatus = status;
    _currentPage = 1;
    _orders.clear();
    await loadOrderHistory(refresh: true);
  }

  /// Load order statuses from API
  Future<void> loadOrderStatuses() async {
    try {
      _orderStatuses = await OrderApiService.getOrderStatuses();

      // Set initial status to first status if _selectedStatus is still 'all'
      if (_selectedStatus == 'all' && _orderStatuses.isNotEmpty) {
        _selectedStatus = _orderStatuses.first['id'].toString();
      }

      notifyListeners();
    } catch (e) {
      print('Error loading order statuses: $e');
      // Keep default empty list
    }
  }

  /// Get status color from API data
  Color getStatusColor(String statusName) {
    final status = _orderStatuses.firstWhere(
      (s) => s['name'] == statusName.toLowerCase(),
      orElse: () => {'color': '#6c757d'},
    );

    final colorString = status['color'] as String;
    if (colorString.startsWith('#')) {
      return Color(int.parse(colorString.substring(1), radix: 16) + 0xFF000000);
    }
    return Colors.grey;
  }
}
