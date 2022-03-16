import 'package:ap4_gsbmedecins_appli/entities/Departement.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Doctor.g.dart';

@JsonSerializable(explicitToJson: true)
class Doctor {
  @JsonKey(required: false)
  int? id;
  String nom, prenom, adresse, tel;
  String? spec;
  @JsonKey(required: false)
  Departement? departement;

  Doctor({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.adresse,
    required this.tel,
    this.spec,
    this.departement
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}