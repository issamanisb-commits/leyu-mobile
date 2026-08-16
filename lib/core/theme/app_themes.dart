import 'package:flutter/material.dart';

class AppThemes {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.amber,
    scaffoldBackgroundColor: Colors.white, // or your light bg
    fontFamily: 'openSans',
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    scaffoldBackgroundColor: const Color(0xFF000000), // Pure black background
    fontFamily: 'openSans',
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF000000),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor: const Color(0xFF2C2C2C), // Lighter grey for distinct cards
    iconTheme: const IconThemeData(color: Colors.white), // Explicitly white icons
    listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  );
}
