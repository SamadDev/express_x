import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    scaffoldBackgroundColor: kLightPlatinum50,
    appBarTheme: AppBarTheme(
      backgroundColor: kLightAppBar,
      iconTheme: IconThemeData(color: kLightTitle),
      elevation: 0,
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
