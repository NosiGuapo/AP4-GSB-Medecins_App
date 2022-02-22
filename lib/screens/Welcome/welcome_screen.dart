import 'package:ap4_gsbmedecins_appli/screens/Welcome/components/body.dart';
import 'package:ap4_gsbmedecins_appli/themes.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

// stless to trigger the class
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feur"),
        backgroundColor: primaryColour,
        actions: [
          IconButton(
              icon: const Icon(Icons.brightness_4_rounded),
            onPressed: () {
                actualTheme.toggleTheme();
            },
          )
        ],
      ),
      body: const Body(),
    );
  }
}
