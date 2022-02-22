import 'package:ap4_gsbmedecins_appli/components/input_password_field.dart';
import 'package:ap4_gsbmedecins_appli/components/primary_button.dart';
import 'package:ap4_gsbmedecins_appli/screens/SignIn/components/background.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/components/input_field.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        bg: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 35),
          child: const Text(
            "Connexion",
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Roboto"),
          ),
        ),
        // Mail
        const InputFields(
          text: "E-mail",
          onChanged: null,
        ),
        // Password
        const PasswordField(
          text: "Mot de passe",
          onChanged: null,
        ),
        const RoundPcButton(
            text: "Valider",
            onPressed: null
        ),
      ],
    ));
  }
}
