import 'package:flutter/material.dart';
import 'package:x_express/core/config/widgets/globalText.dart';

class Servicedetail extends StatelessWidget {
  const Servicedetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF5C3A9E),
        title: GlobalText(
         "Service Detail",
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      body: Center(
        child: GlobalText( "Empty"),
      ),
    );
  }
}
