import 'package:ap4_gsbmedecins_appli/constants.dart';
import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

// ChangeNotifier acts like a listener which will help our method to update itself
class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  // Depending on the boolean value, the correct theme will be applied
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  // Method toggling the theme
  void toggleTheme() {
    // Whenever a button in charge of managing the dark/light mode is pressed, the boolean value will be set to the opposite
    // Which will toggle the opposite theme and switch from one mode to another
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
        backgroundColor: lightBgColour,
        scaffoldBackgroundColor: lightBgColour,
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.black),
          headline2: TextStyle(color: Colors.black),
          headline3: TextStyle(color: Colors.black),
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
        )
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      backgroundColor: darkBgColour,
      scaffoldBackgroundColor: darkBgColour,
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        headline3: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
      )
    );
  }
}
