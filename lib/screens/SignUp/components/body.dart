import 'package:ap4_gsbmedecins_appli/screens/SignUp/components/background.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/constants.dart';

// stless to trigger the class
class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      bg: Column(
        children: <Widget>[],
      ),
    );
  }
}
