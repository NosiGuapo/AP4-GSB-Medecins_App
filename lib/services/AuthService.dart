import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../entities/Auth.dart';

class AuthService{
  static Future<List> attemptAuthentication(String username, String password) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/login');
    final response = await http.put(
        url,
        headers: {
          "Accept": "application/x-www-form-urlencoded",
          "content-type": "application/x-www-form-urlencoded"
        },
        body: {
          "username": username,
          "password": password
        }
    );

    if (response.statusCode == 200){
      Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var credentials = Auth.fromJson(body);
      return [true, response.statusCode, "Connexion réussie, bienvenue", credentials.accessToken, credentials.refreshToken];
    } else {
      return [false, response.statusCode, "L'utilisateur spécifié n'apparait pas dans nos registres."];
    }
  }

  static Future<Auth> getSession() async {
    var accessToken = await FlutterSession().get('access_token');
    var refreshToken = await FlutterSession().get('refresh_token');
    Auth session = Auth(accessToken: accessToken, refreshToken: refreshToken);
    return session;
  }
}