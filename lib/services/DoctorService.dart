import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorService{
  static Future<List<Doctor>> getDoctors(String? value) async{
    final Uri url;
    if (value == null){
      // If null : We get all the doctors
      url = Uri.parse('http://10.0.2.2:8080/gsb/medecins');
      // url = Uri.parse('http://172.31.1.95:8080/gsb/medecins');
    } else {
      // If not null : a search is currently happening, we display the doctors by their name
      url = Uri.parse('http://10.0.2.2:8080/gsb/medecins/lname/'+value.toString());
      // url = Uri.parse('http://172.31.1.95:8080/gsb/medecins/lname/'+value.toString());
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