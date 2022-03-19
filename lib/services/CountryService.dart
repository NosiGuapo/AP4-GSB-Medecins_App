import 'package:ap4_gsbmedecins_appli/entities/Country.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryService{
  static Future<List<Country>> getCountries() async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/pays');

    final response = await http.get(url);
    if (response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var countries = body.map((body) {
        return Country.fromJson(body);
      }).toList();
      return countries;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getDoctors): Erreur '+response.statusCode.toString());
      return List<Country>.empty();
    }
  }

  static Future<Country?> getCountryById(int? id) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/pays/'+id.toString());

    final response = await http.get(url);
    if (response.statusCode == 200){
      Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var country = Country.fromJson(body);
      return country;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getCountryById): Erreur '+response.statusCode.toString());
      return null;
    }
  }

  static Future<bool> deleteCountry(int id) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/pays/'+id.toString());
    final response = await http.delete(url);

    if (response.statusCode == 200){
      return true;
    } else {
      print('Une erreur est survenue lors de la suppression du pays: Erreur '+response.statusCode.toString());;
      return false;
    }
  }
}