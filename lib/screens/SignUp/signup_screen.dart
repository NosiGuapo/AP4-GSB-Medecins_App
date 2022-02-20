import 'package:ap4_gsbmedecins_appli/screens/SignUp/components/body.dart';
import 'package:flutter/material.dart';

// stless to trigger the class
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}