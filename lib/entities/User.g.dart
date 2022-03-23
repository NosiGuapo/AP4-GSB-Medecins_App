// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      lname: json['lname'] as String,
      fname: json['fname'] as String,
      username: json['username'] as String,
      mail: json['mail'] as String,
      passwd: json['passwd'] as String,
      register: json['register'] == null
          ? null
          : DateTime.parse(json['register'] as String),
      invitation: (json['invitation'] as List<dynamic>?)
          ?.map((e) => Invitation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'lname': instance.lname,
      'fname': instance.fname,
      'username': instance.username,
      'mail': instance.mail,
      'passwd': instance.passwd,
      'register': instance.register?.toIso8601String(),
      'invitation': instance.invitation?.map((e) => e.toJson()).toList(),
    };
