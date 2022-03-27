import 'package:ap4_gsbmedecins_appli/entities/Departement.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegionService{
  static Future<List<Departement>> getRegions() async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/departements');

    final response = await http.get(url);
    if (response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var regions = body.map((body) {
        return Departement.fromJson(body);
      }).toList();
      return regions;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getRegions): Erreur '+response.statusCode.toString());
      return List<Departement>.empty();
    }
  }

  static Future<List<Departement>> getRegionsOfCountry(int id) async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/pays/'+id.toString()+'/departements');

    final response = await http.get(url);
    if (response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var regions = body.map((body) {
        return Departement.fromJson(body);
      }).toList();
      return regions;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getRegionsOfCountry): Erreur '+response.statusCode.toString());
      return List<Departement>.empty();
    }
  }

  static Future<bool> createRegion(Departement departement) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/departements/');
    var body = jsonEncode(departement.toJson());
    final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: body
    );

    if (response.statusCode == 201){
      // 201 is the default "CREATED" status code
      return true;
    } else {
      print('Une erreur est survenue lors de la l\'ajout du pays: Erreur '+response.statusCode.toString());;
      return false;
    }
  }
}