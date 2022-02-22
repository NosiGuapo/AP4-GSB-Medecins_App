import 'package:ap4_gsbmedecins_appli/screens/Welcome/welcome_screen.dart';
import 'package:ap4_gsbmedecins_appli/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Setting up the listener
    super.initState();
    actualTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide demo banner
      debugShowCheckedModeBanner: false,
      title: 'GSB Médecins',
      home: const WelcomeScreen(),
      // Setting up the custom themes created in theme.dart
      //
      // Default theme
      theme: CustomTheme.lTheme,
      // themeMode is here to call the CustomTheme object created in the theme.dart file
      // This object will be set to either dark or light mode according to "_isDarkTheme" boolean value
      themeMode: actualTheme.actualTheme,
      darkTheme: CustomTheme.dTheme,
    );
  }
}
