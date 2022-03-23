// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invitation _$InvitationFromJson(Map<String, dynamic> json) => Invitation(
      id: json['id'] as int?,
      key: json['key'] as String,
      maxuses: json['maxuses'] as int,
      currentuses: json['currentuses'] as int,
      creation: DateTime.parse(json['creation'] as String),
      owner: json['owner'] as int,
    );

Map<String, dynamic> _$InvitationToJson(Invitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'maxuses': instance.maxuses,
      'currentuses': instance.currentuses,
      'creation': instance.creation.toIso8601String(),
      'owner': instance.owner,
    };
