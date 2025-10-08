import "package:x_express/Utils/exports.dart";
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ShipmentTrack extends StatelessWidget {
  final containerNum;

  const ShipmentTrack({Key? key, this.containerNum}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(containerNum);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      appBar: AppBar(title: Text(language["track"] ?? "Track")),
      body: Consumer<ShipmentDetailServices>(
          builder: (ctx, track, _) => Stack(
            alignment: Alignment.center,
                children: [
                  InAppWebView(
                    onLoadStop: (controller, url) {
                      print("stop from playing");
                      track.setLoading(false);
                    },
                    onLoadStart: (controller, url) {
                      print("stop from playing");
                      track.setLoading(true);
                    },
                    initialUrlRequest: URLRequest(
                      url: WebUri("https://shipsgo.com/live-map-container-tracking?query=$containerNum"),
                    ),
                  ),
                  track.isStart ? CircularProgressIndicator(color:AppTheme.primary) : SizedBox.shrink()
                ],
              )),
    );
  }
}
