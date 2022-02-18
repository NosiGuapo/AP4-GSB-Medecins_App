import 'package:ap4_gsbmedecins_appli/screens/Welcome/components/body.dart';
import 'package:flutter/material.dart';

// stless to trigger the class
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
