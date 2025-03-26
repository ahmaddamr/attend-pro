import 'package:attend_pro/core/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.color4,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.color1,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white),
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 13,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
      onPrimary: Colors.white,
      surface: Colors.grey.shade200,
      onSurface: Colors.black,
    ),
  );

  final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.color3,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.color1,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white),
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.black,
      secondary: Colors.blueGrey,
      onPrimary: const Color(0xff141922),
      surface: Colors.grey.shade800,
      onSurface: Colors.white,
    ),
  );
}
