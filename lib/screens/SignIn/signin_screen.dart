import 'package:ap4_gsbmedecins_appli/screens/SignIn/components/body.dart';
import 'package:flutter/material.dart';

// stless to trigger the class
class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
