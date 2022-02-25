import 'package:flutter/material.dart';
import '../constants.dart';

class AuthSubtextRedirect extends StatelessWidget {
  final bool login;
  final void Function()? onPress;

  const AuthSubtextRedirect({
    this.login = false,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 65),
      child: Row(
        // Align center
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? "Vous n'avez pas de compte ?" : "Vous possédez un compte ?",
            style: const TextStyle(color: primaryColour),
          ),
          Padding(
              // Avoiding bold text to stick to the previous text
              padding: const EdgeInsets.only(left: 5),
              child: GestureDetector(
                onTap: onPress,
                child: Text(
                  login ? "Inscription" : "Connexion",
                  style: const TextStyle(
                      color: primaryColour, fontWeight: FontWeight.bold
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
