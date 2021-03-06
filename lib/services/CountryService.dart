import 'package:ap4_gsbmedecins_appli/entities/Country.dart';
import 'package:ap4_gsbmedecins_appli/services/AuthService.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryService{
  static Future<List<Country>> getCountries() async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/pays');
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      // "GSB WT " is here to identify the token
      "Authorization": await FlutterSession().get('access_token')
    });
    if (response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var countries = body.map((body) {
        return Country.fromJson(body);
      }).toList();
      return countries;
    } else {
      return List<Country>.empty();
    }
  }

  static Future<Country?> getCountryById(int? id) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/pays/'+id.toString());
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": await FlutterSession().get('access_token')
    });
    if (response.statusCode == 200){
      Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var country = Country.fromJson(body);
      return country;
    } else {
      return null;
    }
  }

  static Future<List> deleteCountry(int id) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/pays/'+id.toString());
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    final response = await http.delete(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": await FlutterSession().get('access_token')
    });
    if (response.statusCode == 200){
      return [true, response.statusCode];
    } else {
      return [false, response.statusCode, "Une erreur est survenue lors de la suppression du pays"];
    }
  }

  static Future<List> createCountry(Country country) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/pays/');
    await AuthService.refreshToken(await FlutterSession().get('access_token'));
    var body = jsonEncode(country.toJson());
    final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": await FlutterSession().get('access_token')
        },
        body: body
      );

    if (response.statusCode == 201){
      // 201 is the default "CREATED" status code
      return [true, response.statusCode];
    } else {
      return [false, response.statusCode, "Une erreur est survenue lors de la l'ajout du pays"];
    }
  }

  static Future<List> editCountry(Country country) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/pays/');
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    var body = jsonEncode(country.toJson());
    final response = await http.put(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": await FlutterSession().get('access_token')
        },
        body: body
    );

    if (response.statusCode == 202){
      // 202 is the default "ACCEPTED" status code
      return [true, response.statusCode];
    } else {
      return [false, response.statusCode, "Une erreur est survenue lors de la modification du pays"];
    }
  }
}