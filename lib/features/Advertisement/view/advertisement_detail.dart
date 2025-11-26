import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/html_viewer.dart';
import 'package:x_express/features/Advertisement/view/advertisement.dart';

class AdvertisementDetailScreen extends StatelessWidget {
  final AdvertisementModel advertisement;

  const AdvertisementDetailScreen({
    Key? key,
    required this.advertisement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If type is 'link' and URL is provided, show webview
    if (advertisement.type == 'link' &&
        advertisement.url != null &&
        advertisement.url!.isNotEmpty) {
      return _buildWebView(context);
    }

    // If type is 'content' and description is provided, show HTML content
    if (advertisement.type == 'content' &&
        advertisement.description != null &&
        advertisement.description!.isNotEmpty) {
      return _buildHtmlView(context);
    }

    // Default: show image only
    return _buildImageView(context);
  }

  Widget _buildWebView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(advertisement.title),
        backgroundColor: kLightPrimary,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(advertisement.url!)),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          domStorageEnabled: true,
          databaseEnabled: true,
          clearCache: false,
          cacheEnabled: true,
          allowsInlineMediaPlayback: true,
          mediaPlaybackRequiresUserGesture: false,
          allowsAirPlayForMediaPlayback: true,
          allowsBackForwardNavigationGestures: true,
          supportZoom: false,
          disableHorizontalScroll: false,
          disableVerticalScroll: false,
        ),
      ),
    );
  }

  Widget _buildHtmlView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(advertisement.title),
        backgroundColor: kLightPrimary,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(advertisement.image),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  advertisement.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kLightPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                HtmlViewer(advertisement.description!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(advertisement.title),
        backgroundColor: kLightPrimary,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Image.network(
          advertisement.image,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.broken_image,
              size: 100,
              color: Colors.grey,
            );
          },
        ),
      ),
    );
  }
}
