import 'package:flutter/material.dart';
import '../constants.dart';

class PasswordField extends StatelessWidget {
  final String text;
  final IconData icon;
  final ValueChanged<String>? onChanged;

  const PasswordField({
    Key? key,
    required this.text,
    this.icon = Icons.lock,
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
      child: TextField(
        // Makes input content unclear
        obscureText: true,
        decoration: InputDecoration(
          hintText: text,
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
      width: size.width * 0.7,
    );
  }
}
