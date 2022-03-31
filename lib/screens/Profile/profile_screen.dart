import 'package:ap4_gsbmedecins_appli/screens/Profile/components/body.dart';
import 'package:flutter/material.dart';

// stless to trigger the class
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}