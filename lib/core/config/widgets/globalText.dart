import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_express/core/config/language/language.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:provider/provider.dart';

class GlobalText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final int maxLines;
  final TextDecoration decoration;

  const GlobalText(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.maxLines = 4,
    this.fontFamily = 'intel',
    this.fontWeight = FontWeight.w400,
    this.color = kLightTitle,
    this.textAlign = TextAlign.start,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Language>(
        builder: (ctx, language, _) => Text(
              language.getWords[text] ?? text,
              textAlign: textAlign,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
                decoration: decoration,
              ),
            ));
  }
}
