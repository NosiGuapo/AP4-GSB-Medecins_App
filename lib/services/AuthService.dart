import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../entities/Auth.dart';

class AuthService {
  static Future<List> attemptAuthentication(String username, String password) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/login');
    final response = await http.put(url, headers: {
      "Accept": "application/x-www-form-urlencoded",
      "content-type": "application/x-www-form-urlencoded"
    }, body: {
      "username": username,
      "password": password
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var credentials = Auth.fromJson(body);
      return [
        true,
        response.statusCode,
        "Connexion réussie.",
        credentials.access_token,
        credentials.refresh_token
      ];
    } else {
      return [
        false,
        response.statusCode,
        "L'utilisateur spécifié n'apparait pas dans nos registres."
      ];
    }
  }

  static Future<Auth> getSession() async {
    Auth session = Auth(
        refresh_token: await FlutterSession().get('refresh_token'),
        username: await FlutterSession().get('username'),
        fname: await FlutterSession().get('fname'),
        lname: await FlutterSession().get('lname'),
        access_token: await FlutterSession().get('access_token'),
      // roles: await FlutterSession().get('roles')
    );
    return session;
  }

  static Future<void> setSession(Auth credentials) async {
    await FlutterSession().set('access_token', credentials.access_token);
    await FlutterSession().set('refresh_token', credentials.refresh_token);
    await FlutterSession().set('username', credentials.username);
    await FlutterSession().set('lname', credentials.lname);
    await FlutterSession().set('fname', credentials.fname);
    // await FlutterSession().set('roles', credentials.roles?.first);
  }

  static Future<List> destroySession() async {
    await FlutterSession().set('access_token', '');
    await FlutterSession().set('refresh_token', '');
    await FlutterSession().set('username', '');
    await FlutterSession().set('fname', '');
    await FlutterSession().set('lname', '');
    await FlutterSession().set('roles', '');

    return [true, "Vous avez été déconnecté."];
  }

  static Future<List> refreshToken(Auth user) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/token/refresh');
    var token = "GSB_WT ${user.access_token}";
    List result;
    print(token);

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      // "GSB WT " is here to identify the token
      "Authorization": token
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var newToken = Auth.fromJson(body);
      print(newToken.access_token);
      await FlutterSession().set('access_token', newToken.access_token);
      result = [true, response.statusCode, "Jeton mis à jour."];
    } else {
      result = [false, response.statusCode, "Une erreur est survenue lors du rafraîchissement du jeton."];
    }
    return result;
  }
}
