import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Bag/bag_service.dart';
import 'package:x_express/features/Store/add_to_bag_dialog.dart';
import 'package:x_express/features/Store/bag_screen.dart';

class StoreWebViewScreen extends StatefulWidget {
  final String storeUrl;
  final String storeName;

  const StoreWebViewScreen({
    Key? key,
    required this.storeUrl,
    required this.storeName,
  }) : super(key: key);

  @override
  State<StoreWebViewScreen> createState() => _StoreWebViewScreenState();
}

class _StoreWebViewScreenState extends State<StoreWebViewScreen> {
  InAppWebViewController? webViewController;
  bool isLoading = true;
  bool canGoBack = false;
  bool canGoForward = false;
  bool _isWebViewInitialized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storeName),
        backgroundColor: kLightSurface,
        foregroundColor: kLightText,
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
                          color: kLightPrimary,
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
            initialUrlRequest: URLRequest(url: WebUri(widget.storeUrl)),
            onWebViewCreated: (controller) {
              if (!_isWebViewInitialized) {
                webViewController = controller;
                _isWebViewInitialized = true;
              }
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
              color: kLightSurface,
              child: Center(
                child: CircularProgressIndicator(
                  color: kLightPrimary,
                ),
              ),
            ),
          // Floating Add to Bag Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () {
                _showAddToBagDialog();
              },
              backgroundColor: kLightPrimary,
              foregroundColor: Colors.white,
              icon: Icon(Icons.shopping_bag),
              label: Text(
                'Add to Bag',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: kLightSurface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 10,
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
              color: canGoBack ? kLightText : kLightLightGrayText,
            ),
            IconButton(
              onPressed: () => webViewController?.reload(),
              icon: Icon(Icons.refresh),
              color: kLightText,
            ),
            IconButton(
              onPressed: canGoForward ? () => webViewController?.goForward() : null,
              icon: Icon(Icons.arrow_forward_ios),
              color: canGoForward ? kLightText : kLightLightGrayText,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BagScreen()),
                );
              },
              icon: Icon(Icons.shopping_bag),
              color: kLightText,
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

  @override
  void dispose() {
    // Clean up webview resources
    if (webViewController != null) {
      webViewController = null;
    }
    _isWebViewInitialized = false;
    super.dispose();
  }
}
