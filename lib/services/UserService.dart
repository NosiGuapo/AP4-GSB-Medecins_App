import 'package:ap4_gsbmedecins_appli/entities/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService{

  static Future<List<User>> getAllUsers() async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/utilisateurs');
    final response = await http.get(url);

    if (response.statusCode == 200){
      final body = json.decode(response.body);
      // Show retrieved data
      // print(body);
      return body.map<User>(User.fromJson).toList();
    } else {
      print('Une erreur est survenue lors de l\'accès aux données.');
      return List<User>.empty();
    }
  }
}