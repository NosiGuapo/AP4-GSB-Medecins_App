import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:ap4_gsbmedecins_appli/services/AuthService.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorService{
  static Future<List<Doctor>> getDoctors(String? value) async{
    final Uri url;
    if (value == null){
      // If null : We get all the doctors
      url = Uri.parse('http://10.0.2.2:8080/gsb/medecins');
    } else {
      // If not null : a search is currently happening, we display the doctors by their name
      url = Uri.parse('http://10.0.2.2:8080/gsb/medecins/name?name='+value.toString());
    }
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": await FlutterSession().get('access_token')
    });
    if (response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var doctors = body.map((body) {
        return Doctor.fromJson(body);
      }).toList();
      return doctors;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getDoctors): Erreur '+response.statusCode.toString());
      return List<Doctor>.empty();
    }
  }

  static Future<Doctor?> getDoctorById(int? id) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/medecins/'+id.toString());
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": await FlutterSession().get('access_token')
    });
    if (response.statusCode == 200){
      Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var doctor = Doctor.fromJson(body);
      return doctor;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getDoctorById): Erreur '+response.statusCode.toString());
      return null;
    }
  }

  static Future<Set<String>> getSpecs() async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/medecins/specs');;
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": await FlutterSession().get('access_token')
    });
    if (response.statusCode == 200){
      Set<String> body = Set<String>.from(json.decode(utf8.decode(response.bodyBytes)));
      return body;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getSpecs): Erreur '+response.statusCode.toString());
      return <String>{};
    }
  }

  static Future<List<Doctor>> getDoctorsBySpec(String spec) async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/medecins/spec?spec='+spec.toString());
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": await FlutterSession().get('access_token')
    });
    if (response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var doctors = body.map((body) {
        return Doctor.fromJson(body);
      }).toList();
      return doctors;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getDoctorsBySpec): Erreur '+response.statusCode.toString());
      return List<Doctor>.empty();
    }
  }

  static Future<List<Doctor>> getDoctorsOfRegion(int regionId) async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/departements/'+regionId.toString()+'/medecins');
    await AuthService.refreshToken(await FlutterSession().get('access_token'));;

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": await FlutterSession().get('access_token')
    });
    if (response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var doctors = body.map((body) {
        return Doctor.fromJson(body);
      }).toList();
      return doctors;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getDoctorsOfRegion): Erreur '+response.statusCode.toString());
      return List<Doctor>.empty();
    }
  }

  static Future<List<Doctor>> getDoctorsOfCountry(int countryId) async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/pays/'+countryId.toString()+'/medecins');
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": await FlutterSession().get('access_token')
    });
    if (response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var doctors = body.map((body) {
        return Doctor.fromJson(body);
      }).toList();
      return doctors;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getDoctorsOfCountry): Erreur '+response.statusCode.toString());
      return List<Doctor>.empty();
    }
  }

  static Future<bool> deleteDoctor(int id) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/medecins/'+id.toString());
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    final response = await http.delete(url, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": await FlutterSession().get('access_token')
    });

    if (response.statusCode == 200){
      return true;
    } else {
      print('Une erreur est survenue lors de la suppression du docteur: Erreur '+response.statusCode.toString());;
      return false;
    }
  }

  static Future<bool> createDoctor(Doctor doctor) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/medecins/');
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    var body = jsonEncode(doctor.toJson());
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
      return true;
    } else {
      print('Une erreur est survenue lors de la l\'ajout du médecin: Erreur '+response.statusCode.toString());;
      return false;
    }
  }

  static Future<List> editDoctor(Doctor doctor) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/medecins/');
    await AuthService.refreshToken(await FlutterSession().get('access_token'));

    var body = jsonEncode(doctor.toJson());
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
      return [false, response.statusCode, "Une erreur est survenue lors de la modification du médecin"];
    }
  }
}