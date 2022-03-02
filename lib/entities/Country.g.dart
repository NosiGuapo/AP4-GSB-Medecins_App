// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      id: json['id'] as int,
      nom: json['nom'] as String,
      departements: (json['departements'] as List<dynamic>)
          .map((e) => Departement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'departements': instance.departements.map((e) => e.toJson()).toList(),
    };
