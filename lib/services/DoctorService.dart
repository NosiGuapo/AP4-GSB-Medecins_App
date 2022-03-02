import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorService{
  static Future<List<Doctor>> getAllDoctors() async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/medecins');
    final response = await http.get(url);

    if (response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var doctors = body.map((body) {
        return Doctor.fromJson(body);
      }).toList();
      return doctors;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getAllUsers).');
      return List<Doctor>.empty();
    }
  }
}