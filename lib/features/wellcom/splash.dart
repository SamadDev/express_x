import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:x_express/features/home/navigation_bar_screen.dart';

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _initializeApp(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SplashWidget());
          }
          final isLoggedIn = snapshot.data ?? false;
          return NavigationBarScreen();
        },
      ),
    );
  }

  Future<bool> _initializeApp( context) async {
    try {
      return false;
    } catch (e) {
      print('Error initializing app: $e');
      rethrow;
    }
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
