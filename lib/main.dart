import 'package:ap4_gsbmedecins_appli/constants.dart';
import 'package:ap4_gsbmedecins_appli/screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide demo banner
      debugShowCheckedModeBanner: false,
      title: 'GSB Médecins',
      theme: ThemeData(
        primaryColor: primaryColour,
        scaffoldBackgroundColor: bgColour,
      ),
      home: const WelcomeScreen(),
    );
  }
}
