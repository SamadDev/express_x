import 'package:x_express/Modules/Activity/promotion.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:x_express/Widgets/catch_image.dart';

class PromotionDetailScreen extends StatelessWidget {
  final PromotionModule promotion;
  PromotionDetailScreen({required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.primary),
        backgroundColor: AppTheme.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            child: CatchImageNetwork(
                boxFit: BoxFit.fill, url: promotion.uri, errorWidget: "image.gif", placeholder: 'image.gif'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  promotion.title!,
                  style: textTheme(context).headlineLarge,
                ),
                SizedBox(
                  height: 12,
                ),
                Html(data: promotion.content),
                Html(data: promotion.content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
