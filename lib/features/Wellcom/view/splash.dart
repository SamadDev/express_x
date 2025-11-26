import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SplashWidget()),
    );
  }
}

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: Image.asset(
          'assets/images/${dotenv.env['LOGO']}',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
