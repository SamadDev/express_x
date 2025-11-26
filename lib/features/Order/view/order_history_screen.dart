import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Home/data/service/order_service.dart';
import 'package:x_express/features/Home/data/model/order_model.dart';
import 'package:x_express/features/Order/view/new_order_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int _selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'All Order',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),
          
          // Filter Chips
          _buildFilterChips(),
          
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

                // Group orders by store
                final groupedOrders = _groupOrdersByStore(orderService.orders);

                return RefreshIndicator(
                  onRefresh: () => orderService.refreshOrders(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: groupedOrders.length,
                    itemBuilder: (context, index) {
                      final storeEntry = groupedOrders.entries.elementAt(index);
                      return _buildStoreOrderCard(
                        context, 
                        storeEntry.key, 
                        storeEntry.value,
                        orderService,
                      );
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

  Map<String, List<Order>> _groupOrdersByStore(List<Order> orders) {
    final Map<String, List<Order>> grouped = {};
    for (var order in orders) {
      if (!grouped.containsKey(order.storeName)) {
        grouped[order.storeName] = [];
      }
      grouped[order.storeName]!.add(order);
    }
    return grouped;
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: _searchController,
          style: TextStyle(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Track your order',
            hintStyle: TextStyle(
              color: Color(0xFF999999),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(Icons.search, color: Color(0xFF666666), size: 22),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: (value) {
            // Implement search functionality
          },
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Consumer<OrderService>(
      builder: (context, orderService, child) {
        final statusTabs = orderService.orderStatuses;

        if (statusTabs.isEmpty) {
          return SizedBox.shrink();
        }

        return Container(
          height: 58,
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: statusTabs.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedTabIndex == index;
              final tab = statusTabs[index];
              final statusName = tab['name'].toString();

              IconData? icon;
              if (statusName.toLowerCase().contains('processing') || 
                  statusName.toLowerCase().contains('way')) {
                icon = Icons.local_shipping_outlined;
              } else if (statusName.toLowerCase().contains('delivered') || 
                         statusName.toLowerCase().contains('completed')) {
                icon = Icons.check_circle_outline;
              } else if (statusName.toLowerCase().contains('cancel')) {
                icon = Icons.cancel_outlined;
              } else if (statusName.toLowerCase().contains('pending')) {
                icon = Icons.access_time;
              }

              return Padding(
                padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                child: FilterChip(
                  selected: isSelected,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          size: 18,
                          color: isSelected ? Colors.white : Colors.grey[700],
                        ),
                        SizedBox(width: 6),
                      ],
                      Text(
                        statusName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Color(0xFF2D2D2D),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                  selectedColor: Color(0xFF2D2D2D),
                  checkmarkColor: Colors.white,
                  side: BorderSide(
                    color: isSelected ? Color(0xFF2D2D2D) : Color(0xFFE0E0E0),
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  showCheckmark: false,
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onSelected: (selected) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                    final statusId = tab['id'].toString();
                    orderService.changeStatusFilter(statusId);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStoreOrderCard(
    BuildContext context,
    String storeName,
    List<Order> orders,
    OrderService orderService,
  ) {
    // Calculate total price for this store
    final totalPrice = orders.fold<double>(
      0, 
      (sum, order) => sum + order.price,
    );

    // Get delivery status from first order (or determine overall status)
    final firstOrder = orders.first;
    String deliveryStatus = _getDeliveryStatusText(firstOrder.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Store Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Row(
              children: [
                // Store Logo
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: _getStoreColor(storeName).withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _getStoreInitial(storeName),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _getStoreColor(storeName),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storeName,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D2D2D),
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        deliveryStatus,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                // Total Price
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFD0D0D0), width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\$${totalPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D2D2D),
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
          
          // Order Items
          ...orders.map((order) => _buildOrderItemRow(context, order, orderService)),
        ],
      ),
    );
  }

  Widget _buildOrderItemRow(BuildContext context, Order order, OrderService orderService) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewOrderDetailsScreen(orderId: order.id),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFF5F5F5),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: order.imageUrl != null && order.imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: order.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Color(0xFFF0F0F0),
                          child: Icon(Icons.image, color: Color(0xFFCCCCCC), size: 24),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Color(0xFFF0F0F0),
                          child: Icon(Icons.image, color: Color(0xFFCCCCCC), size: 24),
                        ),
                      ),
                    )
                  : Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xFFCCCCCC),
                      size: 28,
                    ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID #${order.id}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D2D2D),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined, 
                        size: 15, 
                        color: Color(0xFF999999),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          _getLocationText(order),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF666666),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Color(0xFFCCCCCC), size: 22),
          ],
        ),
      ),
    );
  }

  String _getStoreInitial(String storeName) {
    if (storeName.toLowerCase().contains('amazon')) return 'a';
    if (storeName.toLowerCase().contains('ebay')) return 'e';
    if (storeName.toLowerCase().contains('stock')) return 'X';
    return storeName.isNotEmpty ? storeName[0].toUpperCase() : '?';
  }

  Color _getStoreColor(String storeName) {
    if (storeName.toLowerCase().contains('amazon')) return Color(0xFFFF9900);
    if (storeName.toLowerCase().contains('ebay')) return Color(0xFFE53238);
    if (storeName.toLowerCase().contains('stock')) return Color(0xFF00C853);
    return kLightPrimary;
  }

  String _getDeliveryStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'delivered':
        return 'Delivered';
      case 'processing':
      case 'shipped':
        return 'Delivery today by 12:00 pm';
      case 'pending':
        return 'Processing order';
      default:
        return 'Delivery 14, Jan by 2:00 pm';
    }
  }

  String _getLocationText(Order order) {
    // You can add location data to Order model later
    // For now, return a default location based on order info
    return 'Pasadena, Oklahoma';
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
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Store Header Shimmer
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Row(
              children: [
                // Store Logo Shimmer
                Shimmer.fromColors(
                  baseColor: Color(0xFFE0E0E0),
                  highlightColor: Color(0xFFF5F5F5),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Color(0xFFE0E0E0),
                        highlightColor: Color(0xFFF5F5F5),
                        child: Container(
                          width: 120,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Color(0xFFE0E0E0),
                        highlightColor: Color(0xFFF5F5F5),
                        child: Container(
                          width: 160,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Price Shimmer
                Shimmer.fromColors(
                  baseColor: Color(0xFFE0E0E0),
                  highlightColor: Color(0xFFF5F5F5),
                  child: Container(
                    width: 60,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
          
          // Order Items Shimmer
          ...List.generate(2, (index) => _buildShimmerOrderItem()),
        ],
      ),
    );
  }

  Widget _buildShimmerOrderItem() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF5F5F5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Product Image Shimmer
          Shimmer.fromColors(
            baseColor: Color(0xFFE0E0E0),
            highlightColor: Color(0xFFF5F5F5),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Color(0xFFE0E0E0),
                  highlightColor: Color(0xFFF5F5F5),
                  child: Container(
                    width: double.infinity,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Color(0xFFE0E0E0),
                  highlightColor: Color(0xFFF5F5F5),
                  child: Container(
                    width: 140,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Color(0xFFE0E0E0),
            highlightColor: Color(0xFFF5F5F5),
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
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


}
