import 'package:ap4_gsbmedecins_appli/entities/Auth.dart';
import 'package:ap4_gsbmedecins_appli/screens/SignIn/components/background.dart';
import 'package:ap4_gsbmedecins_appli/screens/Welcome/welcome_screen.dart';
import 'package:ap4_gsbmedecins_appli/services/AuthService.dart';
import 'package:flutter/material.dart';

import '../../../components/snackbar.dart';
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

  Widget buildSession() => Center(
    child: Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 18),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
              radius: 70,
              backgroundColor: primaryColour,
            ),
            const SizedBox(height: 35),
            Text(
              userSession.fname! + " " + userSession.lname!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ListTile(
                //   title: const Text("Nom d'utilisateur"),
                //   subtitle: Text(
                //       userSession.username!),
                //   // leading: const Icon(Icons.person),
                //   isThreeLine: true,
                // ),
                ListTile(
                  title: const Text("token"),
                  subtitle: Text(
                      userSession.access_token!),
                  // leading: const Icon(Icons.person),
                  isThreeLine: true,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Text("Roles:",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Roboto'),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text("${userSession.roles?.length}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontFamily: 'Roboto'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_open, size: 20),
                onPressed: () =>
                  destroyCurrentSession(),
              label: const Text("Déconnexion"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(failSnackbar),
              ),
            )
          ],
        ),
      ],
    ),
  );

  Widget destroyCurrentSession() {
    var process = AuthService.destroySession();
    process.then((value){
      ScaffoldMessenger.of(context)
          .showSnackBar(buildSnackBar(value[0], value[1]));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const WelcomeAnonymous(),
        ),
            (Route<dynamic> route) => false,
      );
    });
    return Container();
  }
}
