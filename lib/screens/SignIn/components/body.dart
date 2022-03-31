import 'package:ap4_gsbmedecins_appli/screens/Profile/profile_screen.dart';
import 'package:ap4_gsbmedecins_appli/screens/SignIn/components/background.dart';
import 'package:ap4_gsbmedecins_appli/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import '../../../components/snackbar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String username = "";
  String password = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Connexion",
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
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Nom d'utilisateur",
                    labelStyle: TextStyle(fontFamily: 'Roboto', fontSize: 15),
                    prefixIcon: Icon(Icons.person),
                    border: null,
                    hintText: "Entrez votre nom d'utilisateur.",
                  ),
                  initialValue: null,
                  validator: (value) {
                    if (value != null && value.length < 2) {
                      return "Le nom d'utilisateur doit contenir au moins 2 caractères.";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) =>
                      setState(() {
                        username = value;
                      }),
                  style: const TextStyle(fontFamily: 'Roboto', fontSize: 12),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    labelStyle: TextStyle(fontFamily: 'Roboto', fontSize: 15),
                    prefixIcon: Icon(Icons.lock),
                    border: null,
                    hintText: "Entrez votre mot de passe.",
                  ),
                  obscureText: true,
                  initialValue: null,
                  validator: (value) {
                    if (value == null) {
                      return "Veuillez saisir un mot de passe.";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) =>
                      setState(() {
                        password = value;
                      }),
                  style: const TextStyle(fontFamily: 'Roboto', fontSize: 12),
                ),
                const SizedBox(height: 55),
                buildSubmit(username, password),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSubmit(String username, String password) =>
      ElevatedButton(
        onPressed: () {
          final isValid = formKey.currentState!.validate();
          if (isValid) {
            formKey.currentState?.save();
            final logTest = AuthService.attemptAuthentication(
                username, password);
            logTest.then((value) {
              if (value[0]) {
                // Setting up session
                setUpSession(value[3], value[4]);
              } else {
                final String snackMessage = value[2];
                ScaffoldMessenger.of(context).showSnackBar(
                    buildSnackBar(value[0], snackMessage));
              }
            });
          }
        },
        child: const Text("Connexion"),
      );

  Widget setUpSession(String accessToken, String refreshToken) {
    Future<void> setTokens() async {
      await FlutterSession().set('access_token', accessToken);
      await FlutterSession().set('refresh_token', refreshToken);
    }

    setTokens().then((value){
      ScaffoldMessenger.of(context).showSnackBar(
          buildSnackBar(true, "Connexion réussie, bienvenue."));

      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const ProfileScreen(),
        ),
      );
    });
    return Container();
  }
}
