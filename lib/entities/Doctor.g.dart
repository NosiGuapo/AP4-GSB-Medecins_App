// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      adresse: json['adresse'] as String,
      tel: json['tel'] as String,
      spec: json['spec'] as String?,
      departement: json['departement'] == null
          ? null
          : Departement.fromJson(json['departement'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'adresse': instance.adresse,
      'tel': instance.tel,
      'spec': instance.spec,
      'departement': instance.departement?.toJson(),
    };
