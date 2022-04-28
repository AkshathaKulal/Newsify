import 'package:flutter/material.dart';
import 'package:newsify_demo/core/utils/config.dart';

import 'constants.dart';

/// @author Akshatha

enum AppTheme {
  Light,
  Dark,
}

final appThemeData = {
  AppTheme.Light: ThemeData(
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontFamily: Constants.POPPINS_BOLD,
              color: Colors.black,
              fontSize: 20),
          titleMedium: TextStyle(
              fontFamily: Constants.POPPINS_LIGHT,
              color: Colors.black,
              fontSize: 15),
          bodyLarge: TextStyle(
              fontFamily: Constants.POPPINS_LIGHT,
              color: Colors.black,
              fontSize: 20),
          headlineLarge: TextStyle(
              fontFamily: Constants.POPPINS_BOLD,
              color: Colors.black,
              fontSize: 15),
          headlineMedium: TextStyle(
              fontFamily: Constants.POPPINS_LIGHT,
              color: Colors.black,
              fontSize: 12)),
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      )),
  AppTheme.Dark: ThemeData(
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontFamily: Constants.POPPINS_BOLD,
              color: Colors.white,
              fontSize: 20),
          titleMedium: TextStyle(
              fontFamily: Constants.POPPINS_LIGHT,
              color: Colors.white,
              fontSize: 15),
          bodyLarge: TextStyle(
              fontFamily: Constants.POPPINS_LIGHT,
              color: Colors.white,
              fontSize: 20),
          headlineLarge: TextStyle(
              fontFamily: Constants.POPPINS_BOLD,
              color: Colors.white,
              fontSize: 15),
          headlineMedium: TextStyle(
              fontFamily: Constants.POPPINS_LIGHT,
              color: Colors.white,
              fontSize: 12)),
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      )),
};

class CurrentTheme {
  static bool _isDark = true;

  ThemeData? getThemeData() {
    return _isDark ? appThemeData[AppTheme.Dark] : appThemeData[AppTheme.Light];
  }

  void switchTheme() {
    print("DARK1:" + _isDark.toString());
    if (_isDark) {
      box.put(Constants.THEME_TAG, false);
      _isDark = false;
    } else {
      box.put(Constants.THEME_TAG, true);
      _isDark = true;
    }
  }

  CurrentTheme() {
    if (box.containsKey(Constants.THEME_TAG)) {
      _isDark = box.get(Constants.THEME_TAG);
    } else {
      box.put(Constants.THEME_TAG, _isDark);
    }
  }
}
