class OrderDetailModel {
  final String id;
  final String orderNumber;
  final String localShipping;
  final String internationalShipping;
  final String tax;
  final String customsClearance;
  final String serviceFee;
  final String subtotal;
  final String totalAmount;
  final String? note;
  final String createdAt;
  final OrderStatus status;
  final bool statusChangable;
  final List<OrderItem> items;

  OrderDetailModel({
    required this.id,
    required this.orderNumber,
    required this.localShipping,
    required this.internationalShipping,
    required this.tax,
    required this.customsClearance,
    required this.serviceFee,
    required this.subtotal,
    required this.totalAmount,
    this.note,
    required this.createdAt,
    required this.status,
    required this.statusChangable,
    required this.items,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return OrderDetailModel(
      id: data['id']?.toString() ?? '',
      orderNumber: data['order_number']?.toString() ?? '',
      localShipping: data['local_shipping']?.toString() ?? '\$ 0',
      internationalShipping: data['international_shipping']?.toString() ?? '\$ 0',
      tax: data['tax']?.toString() ?? '\$ 0',
      customsClearance: data['customs_clearance']?.toString() ?? '\$ 0',
      serviceFee: data['service_fee']?.toString() ?? '\$ 0',
      subtotal: data['subtotal']?.toString() ?? '\$ 0',
      totalAmount: data['total_amount']?.toString() ?? '\$ 0',
      note: data['note']?.toString(),
      createdAt: data['created_at']?.toString() ?? '',
      status: OrderStatus.fromJson(data['status'] ?? {}),
      statusChangable: data['status_changable'] == true,
      items: (data['items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class OrderStatus {
  final String id;
  final String name;
  final String color;

  OrderStatus({
    required this.id,
    required this.name,
    required this.color,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      color: json['color']?.toString() ?? '#000000',
    );
  }
}

class OrderItem {
  final String id;
  final String productName;
  final String link;
  final String productPrice;
  final int quantity;
  final String? store;
  final String? image;
  final String? color;
  final String? size;
  final String? note;

  OrderItem({
    required this.id,
    required this.productName,
    required this.link,
    required this.productPrice,
    required this.quantity,
    this.store,
    this.image,
    this.color,
    this.size,
    this.note,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id']?.toString() ?? '',
      productName: json['product_name']?.toString() ?? '',
      link: json['link']?.toString() ?? '',
      productPrice: json['product_price']?.toString() ?? '\$ 0',
      quantity: int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,
      store: json['store']?.toString(),
      image: json['image']?.toString(),
      color: json['color']?.toString(),
      size: json['size']?.toString(),
      note: json['note']?.toString(),
    );
  }
}


