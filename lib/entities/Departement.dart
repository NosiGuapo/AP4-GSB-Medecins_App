import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Departement.g.dart';

@JsonSerializable()
class Departement {
  int id;
  String nom;
  List<Doctor> medecins;

  Departement({
    required this.id,
    required this.nom,
    required this.medecins,
  });

  factory Departement.fromJson(Map<String, dynamic> json) => _$DepartementFromJson(json);

  Map<String, dynamic> toJson() => _$DepartementToJson(this);
}