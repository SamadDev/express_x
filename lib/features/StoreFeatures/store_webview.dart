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
  String? currentUrl;
  bool isProductPage = false;
  String? productImage;
  String? productTitle;

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
              setState(() {
                currentUrl = url.toString();
                isProductPage = _isProductPage(currentUrl);
              });
              
              if (isProductPage) {
                _extractProductInfo(controller);
              }
              
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
          // Custom Add to Bag Button - Only show on product pages
          if (isProductPage)
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  _showProductDialog();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Color(0xff5d3ebd),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff5d3ebd).withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Add to Bag',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
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

  bool _isProductPage(String? url) {
    if (url == null) return false;
    
    // Common product page patterns for major e-commerce sites
    final productPatterns = [
      '/dp/', // Amazon
      '/product/', // Generic
      '/item/', // Generic
      '/p/', // Generic
      '/products/', // Generic
      'product-', // Generic
      'item-', // Generic
    ];
    
    return productPatterns.any((pattern) => url.toLowerCase().contains(pattern));
  }

  void _extractProductInfo(InAppWebViewController controller) async {
    try {
      // Extract product title
      final titleResult = await controller.evaluateJavascript(source: """
        var title = document.querySelector('h1')?.textContent || 
                   document.querySelector('[data-testid="product-title"]')?.textContent ||
                   document.querySelector('.product-title')?.textContent ||
                   document.title;
        title;
      """);
      
      // Extract product image
      final imageResult = await controller.evaluateJavascript(source: """
        var img = document.querySelector('img[data-testid="product-image"]') ||
                  document.querySelector('.product-image img') ||
                  document.querySelector('#landingImage') ||
                  document.querySelector('img[alt*="product"]') ||
                  document.querySelector('img[src*="product"]');
        img ? img.src : '';
      """);
      
      setState(() {
        productTitle = titleResult?.toString().replaceAll('"', '');
        productImage = imageResult?.toString().replaceAll('"', '');
      });
    } catch (e) {
      print('Error extracting product info: $e');
    }
  }

  void _showProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _ProductDialog(
          productTitle: productTitle ?? 'Product',
          productImage: productImage,
          storeName: widget.storeName,
        );
      },
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

}

class _ProductDialog extends StatefulWidget {
  final String productTitle;
  final String? productImage;
  final String storeName;

  const _ProductDialog({
    required this.productTitle,
    this.productImage,
    required this.storeName,
  });

  @override
  State<_ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<_ProductDialog> {
  String? selectedSize;
  String? selectedColor;
  int quantity = 1;

  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final List<String> colors = ['Black', 'White', 'Red', 'Blue', 'Green', 'Yellow'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Product Image
            if (widget.productImage != null)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(widget.productImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 16),
            
            // Product Title
            Text(
              widget.productTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            
            // Size Selection
            Text(
              'Select Size',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: sizes.map((size) {
                final isSelected = selectedSize == size;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSize = size;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xff5d3ebd) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Color(0xff5d3ebd) : Colors.grey[300]!,
                      ),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            
            // Color Selection
            Text(
              'Select Color',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: colors.map((color) {
                final isSelected = selectedColor == color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xff5d3ebd) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Color(0xff5d3ebd) : Colors.grey[300]!,
                      ),
                    ),
                    child: Text(
                      color,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            
            // Quantity Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Quantity: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                  icon: Icon(Icons.remove_circle_outline),
                  color: quantity > 1 ? Color(0xff5d3ebd) : Colors.grey,
                ),
                Text(
                  '$quantity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => quantity++),
                  icon: Icon(Icons.add_circle_outline),
                  color: Color(0xff5d3ebd),
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedSize != null && selectedColor != null
                        ? () {
                            // Add to bag logic here
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Added to bag: ${widget.productTitle}'),
                                backgroundColor: Color(0xff5d3ebd),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff5d3ebd),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add to Bag',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
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
}
