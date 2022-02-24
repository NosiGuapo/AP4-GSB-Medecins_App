import 'package:ap4_gsbmedecins_appli/screens/Settings/components/background.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        bg: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Paramètres",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: "Roboto"),
            ),
          ],
        )
    );
  }
}
