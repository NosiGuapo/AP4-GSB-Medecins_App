import 'package:flutter/material.dart';

class OptionIcons extends StatelessWidget {
  final IconData icon;
  final Color bgColour;
  const OptionIcons({
    Key? key,
    required this.icon,
    required this.bgColour
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: bgColour
    ),
    child: Icon(icon, color: Colors.white,)
  );
}
