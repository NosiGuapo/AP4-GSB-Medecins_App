import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Column(
        children: const <Widget>[
          Text(
            "Profil",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: "Roboto"),
          ),
        ],
      ),
    );
  }
}
