import 'package:ap4_gsbmedecins_appli/entities/Auth.dart';
import 'package:ap4_gsbmedecins_appli/screens/SignIn/components/background.dart';
import 'package:ap4_gsbmedecins_appli/services/AuthService.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Auth userSession;

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Votre profil",
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                letterSpacing: -0.2),
          ),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black45),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: FutureBuilder<Auth>(
            future: AuthService.getSession(),
            builder: (context, snapshot){
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                      child: CircularProgressIndicator(
                          color: primaryColour, strokeWidth: 2));
                default:
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    userSession = snapshot.data!;
                    return buildSession();
                  }
              }
            }
          ),
        ),
      ),
    );
  }

  Widget buildSession() => Column(
    children: <Widget>[
      const SizedBox(height: 45),
      const CircleAvatar(
        backgroundImage: AssetImage("assets/images/profile.png"),
        radius: 70,
        backgroundColor: primaryColour,
      ),
      const SizedBox(height: 35),
      ListTile(
        title: const Text("Tokens"),
        subtitle: Text(
            "${userSession.accessToken}\n${userSession.refreshToken}"),
        leading: const Icon(Icons.home),
        isThreeLine: true,
      ),
    ],
  );
}
