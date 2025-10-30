import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';

class AppTheme {
  // Modern E-commerce Design System
  static const Color primaryColor = Color(0xFFFF6B35); // Vibrant orange
  static const Color secondaryColor = Color(0xFFFF8C42); // Lighter orange
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light gray background
  static const Color surfaceColor = Colors.white; // White surface
  static const Color textColor = Color(0xFF2D2D2D); // Main text color
  static const Color textSecondaryColor = Color(0xFF666666); // Secondary text

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF2D2D2D),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Color(0xFF2D2D2D),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF2D2D2D),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shadowColor: primaryColor.withOpacity(0.3),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF8F9FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFE5E5E5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFE5E5E5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFE23A3A)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFE23A3A), width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(
        color: Color(0xFF999999),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    cardTheme: CardTheme(
      color: surfaceColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.black.withOpacity(0.05),
    ),
    // cardTheme: CardTheme(
    //   color: kLightStroke,
    //   elevation: 1,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    // ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     elevation: 2,
    //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //   ),
    // ),
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: lightThemeColors.surface,
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: BorderSide(color: lightThemeColors.primary),
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: BorderSide(color: lightThemeColors.primary.withOpacity(0.5)),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: BorderSide(color: lightThemeColors.primary, width: 2),
    //   ),
    // ),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
      // useMaterial3: true,
      // brightness: Brightness.dark,
      // colorScheme: ColorScheme(
      //   brightness: Brightness.dark,
      //   primary: darkThemeColors.primary,
      //   onPrimary: darkThemeColors.onPrimary,
      //   secondary: darkThemeColors.secondary,
      //   onSecondary: darkThemeColors.onSecondary,
      //   error: darkThemeColors.error,
      //   onError: darkThemeColors.onError,
      //   background: darkThemeColors.background,
      //   onBackground: darkThemeColors.onBackground,
      //   surface: darkThemeColors.surface,
      //   onSurface: darkThemeColors.onSurface,
      // ),
      // scaffoldBackgroundColor: darkThemeColors.background,
      // textTheme: _textTheme,
      // appBarTheme: AppBarTheme(
      //   backgroundColor: darkThemeColors.surface,
      //   foregroundColor: darkThemeColors.onSurface,
      //   elevation: 0,
      // ),
      // cardTheme: CardTheme(
      //   color: darkThemeColors.surface,
      //   elevation: 1,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     foregroundColor: darkThemeColors.onPrimary,
      //     backgroundColor: darkThemeColors.primary,
      //     elevation: 2,
      //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //   ),
      // ),
      // inputDecorationTheme: InputDecorationTheme(
      //   filled: true,
      //   fillColor: darkThemeColors.surface,
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(8),
      //     borderSide: BorderSide(color: darkThemeColors.primary),
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(8),
      //     borderSide: BorderSide(color: darkThemeColors.primary.withOpacity(0.5)),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(8),
      //     borderSide: BorderSide(color: darkThemeColors.primary, width: 2),
      //   ),
      // ),
      );
}
