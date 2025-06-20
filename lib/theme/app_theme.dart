import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF6C63FF),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6C63FF),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: GoogleFonts.dmSansTextTheme(),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF6C63FF),
      secondary: const Color(0xFF00BFA6),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSurface: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6C63FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF6C63FF),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: GoogleFonts.dmSansTextTheme(
      ThemeData.dark().textTheme,
    ),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF6C63FF),
      secondary: const Color(0xFF00BFA6),
      surface: const Color(0xFF1E1E1E),
      onPrimary: Colors.white,
      onSurface: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6C63FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
