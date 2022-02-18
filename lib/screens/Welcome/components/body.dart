import 'package:ap4_gsbmedecins_appli/constants.dart';
import 'package:ap4_gsbmedecins_appli/screens/Login/login_screen.dart';
import 'package:ap4_gsbmedecins_appli/screens/Welcome/components/background.dart';
import 'package:flutter/material.dart';

import '../../../components/primary_button.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      // Setting up welcoming message
      child: Column(
        // Centering text
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            // Text styles
            "Bienvenue sur GSB Médecins !",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RoundPcButton(
            // Actions and text may vary, we need to specify its content and action
            text: "Connexion",
            colour: primaryColour,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                  ),
              );
            },
          ),
          RoundPcButton(
            text: "Inscription",
            colour: primaryLightColour,
            textColour: Colors.black87,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

