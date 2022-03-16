import 'package:ap4_gsbmedecins_appli/entities/Country.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Departement.g.dart';

@JsonSerializable(explicitToJson: true)
class Departement {
  int id;
  String nom;
  @JsonKey(required: false)
  Country? pays;

  Departement({
    required this.id,
    required this.nom,
    this.pays,
  });

  factory Departement.fromJson(Map<String, dynamic> json) => _$DepartementFromJson(json);

  Map<String, dynamic> toJson() => _$DepartementToJson(this);
}