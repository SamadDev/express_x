// import "package:x_express/Utils/exports.dart";
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class ShipmentTrack extends StatelessWidget {
//   final containerNum;
//   const ShipmentTrack({Key? key,this.containerNum}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final language = Provider.of<Language>(context, listen: false).getWords;
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(title: Text(language["track"] ?? "Track")),
//       body: InAppWebView(
//
//         initialUrlRequest: URLRequest(
//
//           url: WebUri("https://shipsgo.com/live-map-container-tracking?query=$containerNum"),
//         ),
//       ),
//     );
//   }
// }

import 'package:webview_flutter/webview_flutter.dart';
import 'package:x_express/Utils/exports.dart';

class ShipmentTrack extends StatefulWidget {
  final String containerNum;
  const ShipmentTrack({Key? key, required this.containerNum}) : super(key: key);

  @override
  State<ShipmentTrack> createState() => _ShipmentTrackState();
}

class _ShipmentTrackState extends State<ShipmentTrack> {
  late final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: Text(language["track"] ?? "Track")),
      body: WebView(
        initialUrl: "https://shipsgo.com/live-map-container-tracking?query=${widget.containerNum}",
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith("https://shipsgo.com/live-map-container-tracking?query=${widget.containerNum}")) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
