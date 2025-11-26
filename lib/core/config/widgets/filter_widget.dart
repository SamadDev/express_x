import 'package:flutter/material.dart';
import 'package:x_express/core/config/assets/app_images.dart';
import 'package:x_express/core/config/constant/size.dart';
import 'package:x_express/core/config/custome_image_view.dart';
import 'package:x_express/core/config/theme/color.dart';

class FilterWidget extends StatelessWidget {
  final Function() onTap;
  const FilterWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(SizeAsset.spacing / 2),
        margin: EdgeInsets.all(SizeAsset.spacing / 2),
        decoration:
            BoxDecoration(color: kLightPlatinum50, shape: BoxShape.circle),
        child: CustomImageView(
          imagePath: AppImages.filter,
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}
