import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Bag/bag_service.dart';
import 'package:x_express/features/StoreFeatures/add_to_bag_dialog.dart';
import 'package:x_express/features/StoreFeatures/bag_screen.dart';


class StoreWebViewScreen extends StatefulWidget {
  final String storeUrl;
  final String storeName;
  final String? baseUrl;

  const StoreWebViewScreen({
    Key? key,
    required this.storeUrl,
    required this.storeName,
    this.baseUrl,
  }) : super(key: key);

  @override
  State<StoreWebViewScreen> createState() => _StoreWebViewScreenState();
}

class _StoreWebViewScreenState extends State<StoreWebViewScreen> {
  InAppWebViewController? webViewController;
  bool isLoading = true;
  bool canGoBack = false;
  bool canGoForward = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storeName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Consumer<BagService>(
            builder: (context, bagService, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_bag_outlined),
                    onPressed: () {
                      // Navigate to bag screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BagScreen()),
                      );
                    },
                  ),
                  if (bagService.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Color(0xFFE91E63),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${bagService.itemCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.baseUrl ?? widget.storeUrl)),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });
            },
            onUpdateVisitedHistory: (controller, url, androidIsReload) {
              controller.canGoBack().then((value) {
                setState(() {
                  canGoBack = value;
                });
              });
              controller.canGoForward().then((value) {
                setState(() {
                  canGoForward = value;
                });
              });
            },
            onReceivedServerTrustAuthRequest: (controller, challenge) async {
              return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
            },
            onPermissionRequest: (controller, request) async {
              return PermissionResponse(
                resources: request.resources,
                action: PermissionResponseAction.GRANT,
              );
            },
            onConsoleMessage: (controller, consoleMessage) {
              print("Console: ${consoleMessage.message}");
            },
            onReceivedError: (controller, request, error) {
              print("Error: ${error.description}");
            },
          ),
          if (isLoading)
            Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  color: kLightPrimary,
                ),
              ),
            ),
          // Floating Action Buttons
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Add Order Button
                FloatingActionButton.extended(
                  onPressed: () {
                    _showAddOrderDialog();
                  },
                  backgroundColor: Color(0xFF5C3A9E), // Purple color
                  foregroundColor: Colors.white,
                  icon: Icon(Icons.add_shopping_cart),
                  label: Text(
                    'Add Order',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Add to Bag Button
                FloatingActionButton.extended(
                  onPressed: () {
                    _showAddToBagDialog();
                  },
                  backgroundColor: Color(0xFFE91E63), // Pink color like Amazon
                  foregroundColor: Colors.white,
                  icon: Icon(Icons.shopping_bag),
                  label: Text(
                    'Add to Bag',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: canGoBack ? () => webViewController?.goBack() : null,
              icon: Icon(Icons.arrow_back_ios),
              color: canGoBack ? Colors.black : Colors.grey,
            ),
            IconButton(
              onPressed: () => webViewController?.reload(),
              icon: Icon(Icons.refresh),
              color: Colors.black,
            ),
            IconButton(
              onPressed: canGoForward ? () => webViewController?.goForward() : null,
              icon: Icon(Icons.arrow_forward_ios),
              color: canGoForward ? Colors.black : Colors.grey,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BagScreen()),
                );
              },
              icon: Icon(Icons.shopping_bag),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddToBagDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddToBagDialog(storeName: widget.storeName);
      },
    );
  }

  void _showAddOrderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add order from ${widget.storeName}?'),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Order Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Order URL',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: widget.baseUrl ?? widget.storeUrl),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement order creation logic
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order added successfully!')),
                );
              },
              child: Text('Add Order'),
            ),
          ],
        );
      },
    );
  }
}
