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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final orderService = Provider.of<OrderService>(context, listen: false);
      await orderService.loadOrderStatuses();
      await orderService.loadOrderHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'My Bookings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kLightPrimary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        // Create status tabs from API data with IDs (removed "All" tab)
        final statusTabs = orderService.orderStatuses;
        
        // If no tabs loaded yet, don't show anything
        if (statusTabs.isEmpty) {
          return SizedBox.shrink();
        }
        
        return Container(
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: statusTabs.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedTabIndex == index;
              final statusTab = statusTabs[index];
              final statusId = statusTab['id'].toString();
              final statusName = statusTab['name'].toString();
              
              // Capitalize first letter only
              final displayName = statusName.isEmpty 
                  ? '' 
                  : statusName[0].toUpperCase() + statusName.substring(1);
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                  orderService.changeStatusFilter(statusId);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                        child: Text(
                          displayName,
                          style: TextStyle(
                            color: isSelected ? kLightPrimary : Colors.grey[600],
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      // Underline for active tab
                      if (isSelected)
                        Container(
                          height: 2,
                          width: displayName.length * 9.0, // Approximate width based on text
                          decoration: BoxDecoration(
                            color: kLightPrimary,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        )
                      else
                        SizedBox(height: 2),
                    ],
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
    final statusColor = orderService.getStatusColor(order.status);
    final statusBgColor = Color.fromARGB(30, statusColor.red, statusColor.green, statusColor.blue);
    
    // Format order number (e.g., "SO2024001")
    final orderNumber = order.id.length > 8 ? order.id : 'SO${order.id.padLeft(7, '0')}';
    
    // Format date (e.g., "Oct 15, 2024")
    final formattedDate = _formatOrderDate(order.orderDate);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(order: order),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Order Number and Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order $orderNumber',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getStatusText(order.status),
                      style: TextStyle(
                        fontSize: 13,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16),
              
              // Divider
              Divider(height: 1, color: Colors.grey[200]),
              
              SizedBox(height: 16),
              
              // Product Info
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
                                child: Icon(Icons.image, color: Colors.grey[400], size: 24),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[200],
                                child: Icon(Icons.image, color: Colors.grey[400], size: 24),
                              ),
                            ),
                          )
                        : Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.grey[400],
                            size: 28,
                          ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.productName,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '1 item',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Total Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${order.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: 16),
              
              // View Details Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(order: order),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _formatOrderDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
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