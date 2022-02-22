import 'package:flutter/material.dart';
import '../constants.dart';

class RoundPcButton extends StatelessWidget {
  // Text inside button
  final String text;
  final void Function()? onPressed;
  final Color colour, textColour;

  // Class constructor
  const RoundPcButton({
    Key? key,
    required this.text,
    required this.onPressed,
    // Button colours will never change, we can define them in the constructor
    this.colour = primaryColour,
    this.textColour = lightBgColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // Manage button size
      width: size.width * 0.4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        // Border-radius 20px
        borderRadius: BorderRadius.circular(20),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            // Button background colour
            backgroundColor: colour,
            // Button background tent on hover
            primary: Colors.greenAccent
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w700, color: textColour, fontFamily: 'Roboto'),
          ),
        ),
      ),
    );
  }
}
