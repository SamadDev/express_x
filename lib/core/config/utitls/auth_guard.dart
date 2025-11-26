import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Auth/data/service/auth_service.dart';
import 'package:x_express/core/config/routes/routes.dart';

class AuthGuard {
  /// Shows a dialog asking user to login when accessing protected content
  /// Returns true if user is authenticated or false if they cancelled
  static Future<bool> requireAuth(
    BuildContext context, {
    String? redirectRoute,
  }) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    // If already authenticated, allow access
    if (authService.isAuthenticated) {
      return true;
    }

    // Show dialog asking user to login
    final bool? shouldLogin = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kLightPrimary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    size: 48,
                    color: kLightPrimary,
                  ),
                ),
                SizedBox(height: 20),
                
                // Title
                Text(
                  'Login Required',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kLightText,
                  ),
                ),
                SizedBox(height: 12),
                
                // Message
                Text(
                  'You need to login to access this page.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: kLightLightGrayText,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24),
                
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: kLightPrimary, width: 1.5),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kLightPrimary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kLightPrimary,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    // If user chose to login, navigate to login page
    if (shouldLogin == true) {
      // Store the redirect route if provided
      if (redirectRoute != null) {
        authService.setPostLoginRedirect(redirectRoute);
      }

      // Navigate to login page
      final result = await Navigator.pushNamed(context, AppRoute.login);
      
      // Check if login was successful
      if (result == true && authService.isAuthenticated) {
        return true;
      }
    }

    return false;
  }

  /// Wraps a widget with authentication check
  /// Shows login dialog if user is not authenticated
  static Widget protectedWidget({
    required BuildContext context,
    required Widget child,
    Widget? fallback,
  }) {
    final authService = Provider.of<AuthService>(context);

    if (authService.isAuthenticated) {
      return child;
    }

    return fallback ??
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 64,
                color: kLightLightGrayText,
              ),
              SizedBox(height: 16),
              Text(
                'Login Required',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kLightText,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please login to access this content',
                style: TextStyle(
                  fontSize: 14,
                  color: kLightLightGrayText,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => requireAuth(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kLightPrimary,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Login Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
  }
}


