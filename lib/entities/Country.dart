import 'package:ap4_gsbmedecins_appli/entities/Departement.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Country.g.dart';

@JsonSerializable(explicitToJson: true)
class Country {
  int id;
  String nom;
  List<Departement> departements;

  Country({
    required this.id,
    required this.nom,
    required this.departements,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}


