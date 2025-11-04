import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:x_express/features/Bag/bag_service.dart';
import 'package:x_express/features/home/services/order_service.dart';
import 'package:x_express/features/home/order_history_screen.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/utitls/show_dialog.dart';

class BagScreen extends StatelessWidget {
  const BagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kLightSurface),
        title: Text(
          'Shopping Bag',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kLightPrimary,
        elevation: 0,
        centerTitle: true,
        actions: [
          Consumer<BagService>(
            builder: (context, bagService, child) {
              return IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.white),
                onPressed: bagService.itemCount > 0
                    ? () {
                        _showClearBagDialog(context, bagService);
                      }
                    : null,
              );
            },
          ),
        ],
      ),
      body: Consumer<BagService>(
        builder: (context, bagService, child) {
          if (bagService.itemCount == 0) {
            return _buildEmptyBag();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: bagService.bagItems.length,
                  itemBuilder: (context, index) {
                    final item = bagService.bagItems[index];
                    return _buildBagItem(context, item, bagService);
                  },
                ),
              ),
              _buildCheckoutSection(context, bagService),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyBag() {
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
              Icons.shopping_bag_outlined,
              size: 60,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Your bag is empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add items from stores to see them here',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to explore screen
              // This would be handled by the parent navigation
            },
            icon: Icon(Icons.explore),
            label: Text('Explore Stores'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kLightPrimary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBagItem(BuildContext context, BagItem item, BagService bagService) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: item.imagePath != null && File(item.imagePath!).existsSync()
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(item.imagePath!),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.shopping_bag,
                                color: Colors.grey[400],
                                size: 40,
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.shopping_bag,
                          color: Colors.grey[400],
                          size: 40,
                        ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Link/Name
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12),
                      // Quantity Controls
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final currentQty = item.quantity ?? 1;
                              if (currentQty > 1) {
                                bagService.updateQuantity(item.id, currentQty - 1);
                              }
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.black87,
                                size: 18,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            '${item.quantity ?? 1}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              final currentQty = item.quantity ?? 1;
                              bagService.updateQuantity(item.id, currentQty + 1);
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.black87,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      if (item.size != null && item.size!.isNotEmpty ||
                          item.color != null && item.color!.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            if (item.size != null && item.size!.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Size: ${item.size}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            if (item.color != null && item.color!.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Color: ${item.color}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
                // Remove button
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red[400]),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AreYouSureDialog(
                          title: 'Delete Item',
                          description: 'Are you sure you want to remove this item from your bag?',
                          onApproval: () {
                            bagService.removeFromBag(item.id);
                          },
                          color: kLightPrimary,
                          confirmButtonText: 'Delete',
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            // Store URL
            if (item.storeUrl != null && item.storeUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  onTap: () => _showUrlDialog(context, item.storeUrl!),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.link, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.storeUrl!,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              decoration: TextDecoration.underline,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext buildContext, BagService bagService) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Items:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                '${bagService.itemCount}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kLightPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Add Order Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _addOrder(buildContext, bagService);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kLightPrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Add Order',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          // View Orders Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                _viewOrders(buildContext);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: kLightPrimary,
                side: BorderSide(color: kLightPrimary),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'View Order History',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearBagDialog(BuildContext context, BagService bagService) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Clear Bag'),
          content: Text('Are you sure you want to remove all items from your bag?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                bagService.clearBag();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  void _addOrder(BuildContext context, BagService bagService) {
    // Store the outer context to avoid shadowing
    final outerContext = context;
    
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Add Order'),
          content: Text('Are you sure you want to add this order with ${bagService.itemCount} item(s)?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _processOrder(outerContext, bagService);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kLightPrimary,
                foregroundColor: Colors.white,
              ),
              child: Text('Add Order'),
            ),
          ],
        );
      },
    );
  }

  void _processOrder(BuildContext context, BagService bagService) async {
    // Get OrderService
    final orderService = Provider.of<OrderService>(context, listen: false);
    
    // Store the outer context to avoid shadowing
    final outerContext = context;
    
    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Processing your order...'),
            ],
          ),
        );
      },
    );

    try {
      print('🚀 Starting order creation...');
      // Create order from all bag items
      final result = await orderService.createOrderFromBagItems(bagService.bagItems);
      print('✅ Order created successfully: ${result != null}');
      print('🔍 Checking context.mounted...');

      // Close loading dialog and use the outer context
      if (outerContext.mounted) {
        print('📱 Context mounted: YES, closing dialog...');
        Navigator.pop(outerContext);
        
        // Show success message
        ScaffoldMessenger.of(outerContext).showSnackBar(
          SnackBar(
            content: Text('Order added successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        // Clear the bag after successful order
        bagService.clearBag();
        
        // Navigate to Order History - go back, then navigate to Order History
        print('📱 Navigating to Order History...');
        Navigator.pop(outerContext); // Close bag screen
        Navigator.push(
          outerContext,
          MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
        );
        print('✅ Navigation complete!');
      } else {
        print('❌ Context NOT mounted! Cannot close dialog or navigate.');
      }
    } catch (e) {
      print('❌ Error in order creation: $e');
      // Close loading dialog
      if (outerContext.mounted) {
        Navigator.pop(outerContext);
        
        // Show error message
        ScaffoldMessenger.of(outerContext).showSnackBar(
          SnackBar(
            content: Text('Error creating order: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _viewOrders(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderHistoryScreen(),
      ),
    );
  }

  void _showUrlDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Open Link'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                url,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Would you like to open this link?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Could not launch $url'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kLightPrimary,
                foregroundColor: Colors.white,
              ),
              child: Text('Open'),
            ),
          ],
        );
      },
    );
  }
}
