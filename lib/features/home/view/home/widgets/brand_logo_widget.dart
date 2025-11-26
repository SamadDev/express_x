import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BrandLogoWidget extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback? onTap;

  const BrandLogoWidget({
    super.key,
    required this.name,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              child: image.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.store, color: Colors.grey[400]),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.store, color: Colors.grey[400]),
                      ),
                    )
                  : Image.asset(
                      "assets/images/$image",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
