import 'package:flutter/material.dart';
import '../constants.dart';

class InputFields extends StatelessWidget {
  final String text;
  final IconData icon;
  final ValueChanged<String>? onChanged;

  const InputFields({
    Key? key,
    required this.text,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: primaryLightColour,
          borderRadius: BorderRadius.circular(25)
      ),
      // No "const" since the text and other elements may vary
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
          // No border
          border: InputBorder.none,
          icon: Icon(
            icon,
            color: primaryColour,
          ),
        ),
        onChanged: onChanged,
      ),
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // Reducing fields width
      width: size.width * 0.7,
    );
  }
}
