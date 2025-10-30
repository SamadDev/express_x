import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/home/services/order_service.dart';
import 'package:x_express/features/home/models/order_model.dart';
import 'package:x_express/features/home/order_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    // Trigger initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderService = Provider.of<OrderService>(context, listen: false);
      orderService.loadOrderStatuses();
      orderService.loadOrderHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBackground,
      appBar: AppBar(
        title: Text(
          'Order History',
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
      ),
      body: Column(
        children: [
          // Status Tabs
          _buildStatusTabs(),
          // Order List
          Expanded(
            child: Consumer<OrderService>(
              builder: (context, orderService, child) {
                if (orderService.isLoading && orderService.orders.isEmpty) {
                  return _buildLoadingState();
                }

                if (orderService.error != null && orderService.orders.isEmpty) {
                  return _buildErrorState(orderService.error!);
                }

                if (orderService.orders.isEmpty) {
                  return _buildEmptyOrders();
                }

                return RefreshIndicator(
                  onRefresh: () => orderService.refreshOrders(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: orderService.orders.length + (orderService.hasMorePages ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == orderService.orders.length) {
                        // Load more button
                        return _buildLoadMoreButton(orderService);
                      }
                      
                      final order = orderService.orders[index];
                      return _buildOrderItem(context, order, index, orderService);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTabs() {
    return Consumer<OrderService>(
      builder: (context, orderService, child) {
        // Create status tabs from API data
        final statusTabs = ['All', ...orderService.orderStatuses.map((s) => s['name'].toString().toUpperCase())];
        
        return Container(
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: statusTabs.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedTabIndex == index;
              final status = index == 0 ? 'all' : statusTabs[index].toLowerCase();
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                  orderService.changeStatusFilter(status);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? kLightPrimary : kLightSurface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? kLightPrimary : kLightStroke,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    statusTabs[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : kLightGrayText,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildOrderItem(BuildContext context, Order order, int index, OrderService orderService) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Product Image
                Container(
                  width: 60,
                  height: 60,
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Order #${order.id}',
                        style: TextStyle(
                          fontSize: 14,
                          color: kLightGrayText,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Store: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: kLightLightGrayText,
                            ),
                          ),
                          Text(
                            order.storeName,
                            style: TextStyle(
                              fontSize: 12,
                              color: kLightPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order.status, orderService),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getStatusText(order.status),
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusTextColor(order.status, orderService),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$${order.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kLightPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: kLightGrayText,
                ),
                SizedBox(width: 8),
                Text(
                  'Ordered ${_formatDate(order.orderDate)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: kLightGrayText,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(order: order),
                      ),
                    );
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: kLightPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Order order, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (order.imageUrl != null && order.imageUrl!.isNotEmpty)
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: order.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                Text('Product: ${order.productName}'),
                SizedBox(height: 8),
                Text('Store: ${order.storeName}'),
                SizedBox(height: 8),
                Text('Order #${order.id}'),
                SizedBox(height: 8),
                Text('Status: ${_getStatusText(order.status)}'),
                SizedBox(height: 8),
                Text('Date: ${_formatDate(order.orderDate)}'),
                SizedBox(height: 8),
                Text('Price: \$${order.price.toStringAsFixed(2)}'),
                if (order.description != null && order.description!.isNotEmpty) ...[
                  SizedBox(height: 8),
                  Text('Description: ${order.description}'),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyOrders() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              size: 60,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 24),
          Text(
            'No orders yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kLightGrayText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your order history will appear here',
            style: TextStyle(
              fontSize: 16,
              color: kLightGrayText,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to explore screen
              Navigator.pop(context);
            },
            icon: Icon(Icons.shopping_bag),
            label: Text('Start Shopping'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kLightPrimary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading order history...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red),
          SizedBox(height: 16),
          Text('Error loading orders'),
          SizedBox(height: 8),
          Text(error, textAlign: TextAlign.center),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Provider.of<OrderService>(context, listen: false).refreshOrders();
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton(OrderService orderService) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: orderService.isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => orderService.loadMoreOrders(),
                child: Text('Load More Orders'),
              ),
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
      default:
        return status.toUpperCase();
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
}