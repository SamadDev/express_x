import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';

class HtmlViewer extends StatelessWidget {
  final String htmlContent;

  const HtmlViewer(this.htmlContent, {super.key});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget('''$htmlContent''');
  }
}
