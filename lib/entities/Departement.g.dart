// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Departement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Departement _$DepartementFromJson(Map<String, dynamic> json) => Departement(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      pays: json['pays'] == null
          ? null
          : Country.fromJson(json['pays'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DepartementToJson(Departement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'pays': instance.pays?.toJson(),
    };
