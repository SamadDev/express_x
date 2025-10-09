import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:x_express/Language/language.dart';
import 'package:x_express/pages/Auth/data/service/auth_service.dart';
import 'package:x_express/pages/Auth/data/repository/local_storage.dart';
import 'package:x_express/pages/Auth/logingScreen.dart';
import 'package:x_express/pages/home/home.dart';


class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _initializeApp(context),
        builder: (ctx, snapshot) {
          // Show splash while loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SplashWidget());
          }
          
          // Check for errors
          if (snapshot.hasError) {
            print('Splash Error: ${snapshot.error}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 50, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Error loading app'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Force reload by navigating to login
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                    child: Text('Go to Login'),
                  ),
                ],
              ),
            );
          }
          
          // Navigate based on login status
          final isLoggedIn = snapshot.data ?? false;
          print('Is logged in: $isLoggedIn');
          
          return isLoggedIn ? HomePageNew() : LoginPage();
        },
      ),
    );
  }
  
  Future<bool> _initializeApp(BuildContext context) async {
    try {
      print('Initializing app...');
      
      // Load language settings
      final language = Provider.of<Language>(context, listen: false);
      await language.getLanguageDataInLocal();
      print('Language loaded');
      
      // Load saved credentials
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.loadSavedCredentials();
      print('Credentials loaded');
      
      // Check login status
      final isLoggedIn = await LocalStorage.isLoggedIn();
      print('Login check complete: $isLoggedIn');
      
      return isLoggedIn;
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
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 24),
        child: Image.asset(
          'assets/images/${dotenv.env['LOGO']}',

          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
