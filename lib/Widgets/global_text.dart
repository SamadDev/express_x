import 'package:flutter/material.dart';

class GlobalText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final fontFamily;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final maxLines;
  final decoration;

  const GlobalText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.maxLines = 4,
      this.fontFamily,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      this.textAlign = TextAlign.start,
      this.decoration = TextDecoration.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize ?? 16.0,
          fontWeight: fontWeight,
          color: color,
          fontFamily: "nrt-reg",
          decoration: decoration),
    );
  }
}

