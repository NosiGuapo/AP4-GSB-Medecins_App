import 'package:ap4_gsbmedecins_appli/constants.dart';
import 'package:ap4_gsbmedecins_appli/screens/Welcome/components/background.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      // Setting up welcoming message
      child: Column(
        // Centering text
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            // Text styles
            "Bienvenue sur GSB Médecins !",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RoundPcButton(
            // Actions and text may vary, we need to specify its content and action
            text: "Connexion",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class RoundPcButton extends StatelessWidget {
  // Text inside button
  final String text;
  final Function press;
  final Color colour, textColour;

  // Class constructor
  const RoundPcButton({
    Key? key,
    this.text,
    this.press,
    // Button colours will never change, we can define them in the constructor
    this.colour = primaryColour,
    this.textColour = bgColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // Manage button size
      width: size.width * 0.6,
      child: ClipRRect(
        // Border-radius 20px
        borderRadius: BorderRadius.circular(20),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            // Button text colour
            primary: bgColour,
            backgroundColor: primaryColour,
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w200, color: textColour),
          ),
        ),
      ),
    );
  }
}
