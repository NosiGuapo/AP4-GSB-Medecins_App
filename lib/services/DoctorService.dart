import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
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

    final response = await http.get(url);
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

    final response = await http.get(url);
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

    final response = await http.get(url);
    if (response.statusCode == 200){
      Set<String> body = Set<String>.from(json.decode(utf8.decode(response.bodyBytes)));
      return body;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getSpecs): Erreur '+response.statusCode.toString());
      return <String>{};
    }
  }

  static Future<List<Doctor>> getDoctorsBySpec(String spec) async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/medecins/spec?spec='+spec.toString());;

    final response = await http.get(url);
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

    final response = await http.get(url);
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

  static Future<bool> deleteDoctor(int id) async {
    final url = Uri.parse('http://10.0.2.2:8080/gsb/medecins/'+id.toString());
    // final url = Uri.parse('http://172.31.1.95:8080/gsb/medecins/delete/'+id.toString());
    final response = await http.delete(url);

    if (response.statusCode == 200){
      return true;
    } else {
      print('Une erreur est survenue lors de la suppression du docteur: Erreur '+response.statusCode.toString());;
      return false;
    }
  }
}