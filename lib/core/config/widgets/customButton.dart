import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';

class CustomerButton extends StatelessWidget {
  final String? text;
  final Function() onPress;
  final Color color;
  final Color textColor;
  final double fontSize;
  final String icon;
  final bool isBorder;
  const CustomerButton({
    super.key,
    this.text,
    required this.onPress,
    this.isBorder = false,
    this.color = kLightButton,
    this.textColor = kLightAppBar,
    this.fontSize = 14.0,
    this.icon = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
          border:
              Border.all(color: kLightPlatinum700, width: isBorder ? 1.5 : 0),
          borderRadius: BorderRadius.circular(8)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: Size(336, 47),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPress,
        child: GlobalText(
          text!,
          maxLines: 1,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
