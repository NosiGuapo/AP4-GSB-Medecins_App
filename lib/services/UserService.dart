import 'package:ap4_gsbmedecins_appli/entities/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService{

  static Future<List<User>> getAllUsers() async{
    final url = Uri.parse('http://10.0.2.2:8080/gsb/utilisateurs');
    final response = await http.get(url);

    if (response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      var users = body.map((body) {
        return User.fromJson(body);
      }).toList();
      return users;
    } else {
      print('Une erreur est survenue lors de l\'accès aux données (getAllUsers).');
      return List<User>.empty();
    }
  }
}