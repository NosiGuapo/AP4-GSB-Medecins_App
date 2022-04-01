import 'package:ap4_gsbmedecins_appli/screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dynamic token = await FlutterSession().get('access_token');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "GSB Médecins",
    home: token != '' ?  const WelcomeLogged() : const WelcomeAnonymous(),
  ));
}

