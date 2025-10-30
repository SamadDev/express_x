class Order {
  final String id;
  final String productName;
  final String storeName;
  final String status;
  final double price;
  final DateTime orderDate;
  final String? imageUrl;
  final String? description;

  Order({
    required this.id,
    required this.productName,
    required this.storeName,
    required this.status,
    required this.price,
    required this.orderDate,
    this.imageUrl,
    this.description,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    // Handle both API response formats and mock data
    String status = 'pending';
    if (json['status'] is Map<String, dynamic>) {
      // Real API format: status is an object with id, name, color
      status = json['status']['name']?.toString() ?? 'pending';
    } else if (json['status'] is String) {
      // Mock data format: status is a string
      status = json['status'].toString();
    }

    return Order(
      id: json['id']?.toString() ?? json['order_number']?.toString() ?? '',
      productName: json['product_name']?.toString() ?? json['productName']?.toString() ?? 'Unknown Product',
      storeName: json['store_name']?.toString() ?? json['storeName']?.toString() ?? 'Unknown Store',
      status: status,
      price: _parsePrice(json),
      orderDate: _parseDate(json),
      imageUrl: json['image_url']?.toString() ?? json['imageUrl']?.toString(),
      description: json['description']?.toString() ?? json['note']?.toString(),
    );
  }

  static double _parsePrice(Map<String, dynamic> json) {
    // Try different price fields from API
    if (json['total_amount'] != null) {
      final amount = json['total_amount'].toString().replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(amount) ?? 0.0;
    }
    if (json['price'] != null) {
      if (json['price'] is String) {
        return double.tryParse(json['price']) ?? 0.0;
      } else if (json['price'] is num) {
        return json['price'].toDouble();
      }
    }
    if (json['product_price'] != null) {
      if (json['product_price'] is String) {
        return double.tryParse(json['product_price']) ?? 0.0;
      } else if (json['product_price'] is num) {
        return json['product_price'].toDouble();
      }
    }
    return 0.0;
  }

  static DateTime _parseDate(Map<String, dynamic> json) {
    // Try different date fields from API
    if (json['created_at'] != null) {
      return DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now();
    }
    if (json['order_date'] != null) {
      return DateTime.tryParse(json['order_date'].toString()) ?? DateTime.now();
    }
    if (json['orderDate'] != null) {
      return DateTime.tryParse(json['orderDate'].toString()) ?? DateTime.now();
    }
    return DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'store_name': storeName,
      'status': status,
      'price': price,
      'order_date': orderDate.toIso8601String(),
      'image_url': imageUrl,
      'description': description,
    };
  }
}

class OrderHistoryResponse {
  final List<Order> orders;
  final int totalCount;
  final int currentPage;
  final int totalPages;

  OrderHistoryResponse({
    required this.orders,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
  });

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryResponse(
      orders: (json['orders'] as List<dynamic>?)
          ?.map((order) => Order.fromJson(order))
          .toList() ?? [],
      totalCount: json['total_count'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}
