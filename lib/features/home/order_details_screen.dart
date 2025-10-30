import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/home/models/order_model.dart';
import 'package:x_express/features/home/services/order_service.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBackground,
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(
            color: kLightText,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kLightSurface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kLightText),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: kLightText),
            onPressed: () {
              // Share order details
              _shareOrderDetails(context);
            },
          ),
        ],
      ),
      body: Consumer<OrderService>(
        builder: (context, orderService, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Status Card
                _buildOrderStatusCard(context, orderService),
                SizedBox(height: 16),
                
                // Product Information Card
                _buildProductInfoCard(),
                SizedBox(height: 16),
                
                // Order Information Card
                _buildOrderInfoCard(),
                SizedBox(height: 16),
                
                // Shipping Information Card
                _buildShippingInfoCard(),
                SizedBox(height: 16),
                
                // Payment Information Card
                _buildPaymentInfoCard(),
                SizedBox(height: 16),
                
                // Order Timeline Card
                _buildOrderTimelineCard(),
                SizedBox(height: 16),
                
                // Action Buttons
                _buildActionButtons(context, orderService),
                SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderStatusCard(BuildContext context, OrderService orderService) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kLightSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: kLightPrimary,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Order Status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kLightText,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status, orderService),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getStatusText(order.status),
                  style: TextStyle(
                    color: _getStatusTextColor(order.status, orderService),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Order #${order.id}',
                style: TextStyle(
                  fontSize: 14,
                  color: kLightGrayText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            _getStatusDescription(order.status),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kLightSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.shopping_bag,
                color: kLightPrimary,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Product Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kLightText,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              // Product Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: order.imageUrl != null && order.imageUrl!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: order.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.image, color: Colors.grey[400]),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.image, color: Colors.grey[400]),
                          ),
                        ),
                      )
                    : Icon(
                        Icons.shopping_bag,
                        color: Colors.grey[400],
                        size: 30,
                      ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.productName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kLightText,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Store: ${order.storeName}',
                      style: TextStyle(
                        fontSize: 14,
                        color: kLightGrayText,
                      ),
                    ),
                    if (order.description != null && order.description!.isNotEmpty) ...[
                      SizedBox(height: 8),
                      Text(
                        order.description!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kLightSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: kLightPrimary,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Order Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kLightText,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildInfoRow('Order ID', order.id),
          _buildInfoRow('Order Date', _formatDate(order.orderDate)),
          _buildInfoRow('Total Amount', '\$${order.price.toStringAsFixed(2)}'),
          _buildInfoRow('Payment Method', 'Credit Card'),
          _buildInfoRow('Shipping Method', 'Standard Shipping'),
        ],
      ),
    );
  }

  Widget _buildShippingInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kLightSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_shipping,
                color: kLightPrimary,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Shipping Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kLightText,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildInfoRow('Shipping Address', '123 Main Street, City, State 12345'),
          _buildInfoRow('Tracking Number', 'TRK123456789'),
          _buildInfoRow('Estimated Delivery', '2-3 business days'),
          _buildInfoRow('Shipping Status', 'In Transit'),
        ],
      ),
    );
  }

  Widget _buildPaymentInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kLightSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.payment,
                color: kLightPrimary,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Payment Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kLightText,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildInfoRow('Subtotal', '\$${(order.price * 0.9).toStringAsFixed(2)}'),
          _buildInfoRow('Shipping', '\$${(order.price * 0.05).toStringAsFixed(2)}'),
          _buildInfoRow('Tax', '\$${(order.price * 0.05).toStringAsFixed(2)}'),
          Divider(),
          _buildInfoRow('Total', '\$${order.price.toStringAsFixed(2)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildOrderTimelineCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kLightSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.timeline,
                color: kLightPrimary,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Order Timeline',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kLightText,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildTimelineItem(
            'Order Placed',
            'Your order has been placed successfully',
            order.orderDate,
            true,
          ),
          _buildTimelineItem(
            'Payment Confirmed',
            'Payment has been processed',
            order.orderDate.add(Duration(hours: 1)),
            true,
          ),
          _buildTimelineItem(
            'Order Processing',
            'Your order is being prepared',
            order.orderDate.add(Duration(days: 1)),
            order.status != 'pending',
          ),
          _buildTimelineItem(
            'Shipped',
            'Your order is on its way',
            order.orderDate.add(Duration(days: 2)),
            order.status == 'processing' || order.status == 'completed',
          ),
          _buildTimelineItem(
            'Delivered',
            'Your order has been delivered',
            order.orderDate.add(Duration(days: 3)),
            order.status == 'completed',
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, OrderService orderService) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Track order
              _trackOrder(context);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: kLightPrimary,
              side: BorderSide(color: kLightPrimary),
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Track Order'),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Contact support
              _contactSupport(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kLightPrimary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Contact Support'),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: kLightGrayText,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isTotal ? kLightPrimary : kLightText,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String title, String description, DateTime date, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isCompleted ? kLightPrimary : kLightLightGrayText,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? kLightText : kLightGrayText,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: kLightLightGrayText,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _formatDate(date),
                  style: TextStyle(
                    fontSize: 12,
                    color: kLightLightGrayText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status, OrderService orderService) {
    final apiColor = orderService.getStatusColor(status);
    return Color.fromARGB(30, apiColor.red, apiColor.green, apiColor.blue);
  }

  Color _getStatusTextColor(String status, OrderService orderService) {
    return orderService.getStatusColor(status);
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'pending':
        return 'Pending';
      case 'cancelled':
        return 'Cancelled';
      case 'processing':
        return 'Processing';
      case 'rejected':
        return 'Rejected';
      default:
        return status.toUpperCase();
    }
  }

  String _getStatusDescription(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Your order has been successfully delivered.';
      case 'pending':
        return 'Your order is being processed and will be confirmed soon.';
      case 'cancelled':
        return 'This order has been cancelled.';
      case 'processing':
        return 'Your order is being prepared for shipment.';
      case 'rejected':
        return 'This order has been rejected.';
      default:
        return 'Order status information is not available.';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  void _shareOrderDetails(BuildContext context) {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order details shared successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _trackOrder(BuildContext context) {
    // Implement tracking functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Track Order'),
        content: Text('Tracking number: TRK123456789\nStatus: In Transit\nEstimated delivery: 2-3 business days'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _contactSupport(BuildContext context) {
    // Implement contact support functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contact Support'),
        content: Text('For order #${order.id}, please contact our support team at support@xexpress.com or call +1-800-XXX-XXXX'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

