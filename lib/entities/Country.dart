import 'package:json_annotation/json_annotation.dart';

part 'Country.g.dart';

@JsonSerializable(explicitToJson: true)
class Country {
  int id;
  String nom;

  Country({
    required this.id,
    required this.nom,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}


