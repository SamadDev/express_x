import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatchImageNetwork extends StatelessWidget {
  final url;
  final boxFit;
  final placeholder;
  final errorWidget;
  const CatchImageNetwork({
    this.url,
    this.boxFit,
    this.placeholder = 'image.gif',
    this.errorWidget = 'image.gif',
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      useOldImageOnUrlChange: true,
      width: double.infinity,
      imageUrl: url,
      fit: boxFit,
      placeholder: (context, url) => Image.asset(
        'assets/images/$placeholder',
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/$errorWidget',
        fit: BoxFit.contain,
      ),
    );
  }
}
