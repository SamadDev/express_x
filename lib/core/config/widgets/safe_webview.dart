import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SafeWebView extends StatefulWidget {
  final String initialUrl;
  final Function(InAppWebViewController)? onWebViewCreated;
  final Function(InAppWebViewController, WebUri)? onLoadStart;
  final Function(InAppWebViewController, WebUri)? onLoadStop;
  final Function(InAppWebViewController, WebUri?, bool)? onUpdateVisitedHistory;
  final Function(InAppWebViewController, URLAuthenticationChallenge)?
      onReceivedServerTrustAuthRequest;
  final Function(InAppWebViewController, PermissionRequest)?
      onPermissionRequest;
  final Function(InAppWebViewController, ConsoleMessage)? onConsoleMessage;
  final Function(InAppWebViewController, WebResourceRequest, WebResourceError)?
      onReceivedError;

  const SafeWebView({
    Key? key,
    required this.initialUrl,
    this.onWebViewCreated,
    this.onLoadStart,
    this.onLoadStop,
    this.onUpdateVisitedHistory,
    this.onReceivedServerTrustAuthRequest,
    this.onPermissionRequest,
    this.onConsoleMessage,
    this.onReceivedError,
  }) : super(key: key);

  @override
  State<SafeWebView> createState() => _SafeWebViewState();
}

class _SafeWebViewState extends State<SafeWebView> {
  bool _isInitialized = false;
  bool _hasError = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildErrorWidget();
    }

    return InAppWebView(
      key: ValueKey('webview_${widget.initialUrl.hashCode}'),
      initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
      onWebViewCreated: (controller) {
        if (!_isInitialized) {
          _isInitialized = true;
          widget.onWebViewCreated?.call(controller);
        }
      },
      onLoadStart: (controller, url) {
        if (url != null) {
          widget.onLoadStart?.call(controller, url);
        }
      },
      onLoadStop: (controller, url) {
        if (url != null) {
          widget.onLoadStop?.call(controller, url);
        }
      },
      onUpdateVisitedHistory: (controller, url, androidIsReload) {
        widget.onUpdateVisitedHistory
            ?.call(controller, url, androidIsReload ?? false);
      },
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return widget.onReceivedServerTrustAuthRequest
                ?.call(controller, challenge) ??
            ServerTrustAuthResponse(
                action: ServerTrustAuthResponseAction.PROCEED);
      },
      onPermissionRequest: (controller, request) async {
        return widget.onPermissionRequest?.call(controller, request) ??
            PermissionResponse(
              resources: request.resources,
              action: PermissionResponseAction.GRANT,
            );
      },
      onConsoleMessage: (controller, consoleMessage) {
        widget.onConsoleMessage?.call(controller, consoleMessage);
      },
      onReceivedError: (controller, request, error) {
        print('SafeWebView Error: ${error.description}');
        setState(() {
          _hasError = true;
          _errorMessage = error.description;
        });
        widget.onReceivedError?.call(controller, request, error);
      },
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          SizedBox(height: 16),
          Text(
            'WebView Error',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _errorMessage ?? 'Failed to load web content',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _hasError = false;
                _errorMessage = null;
                _isInitialized = false;
              });
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _isInitialized = false;
    super.dispose();
  }
}
