import 'package:ap4_gsbmedecins_appli/components/input_password_field.dart';
import 'package:ap4_gsbmedecins_appli/components/primary_button.dart';
import 'package:ap4_gsbmedecins_appli/constants.dart';
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
        const RoundPcButton(text: "Valider", onPressed: null),
        Padding(
          padding: const EdgeInsets.only(top: 65),
          child: Row(
            // Align center
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "Vous n'êtes pas inscrit ?",
                style: TextStyle(color: primaryColour),
              ),
              Padding(
                  // Avoiding bold text to stick to the previous text
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Créer un compte",
                    style: TextStyle(
                        color: primaryColour, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        )
      ],
    ));
  }
}
