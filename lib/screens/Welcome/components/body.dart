import 'package:ap4_gsbmedecins_appli/screens/Welcome/components/background.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Bienvenue sur GSB Médecins !")],
      ),
    );
  }
}
