import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_express/features/Auth/data/service/auth_service.dart';
import 'package:x_express/features/home/navigation_bar_screen.dart';
import 'package:x_express/features/Auth/view/login/login.dart';
import 'package:x_express/features/wellcom/new_splash_screen.dart';
import 'package:x_express/core/config/language/language.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      final authService = Provider.of<AuthService>(context, listen: true);
      
      // Initialize auth data only once when the widget first builds
      if (!_hasInitialized) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            authService.loadUserFromLocal().then((_) {
              if (mounted) {
                setState(() {
                  _hasInitialized = true;
                });
              }
            });
          }
        });
        return NewSplashScreen();
      }

      if (authService.isAuthenticated) {
        return NavigationBarScreen();
      } else {
        return LoginPage();
      }
    } catch (e) {
      print('Error accessing AuthService in AuthWrapper: $e');
      // Fallback to LoginPage if provider is not available
      return LoginPage();
    }
  }
}
