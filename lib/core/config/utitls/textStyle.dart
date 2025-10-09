import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_express/core/config/theme/color.dart';

class AppTextStyle {
  static void globalTextSTyl({double? size, Color? color, FontWeight? fontWeight}) {
    GoogleFonts.inter(
      fontSize: size ?? 12,
      color: kLightPlatinum400,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }
}
