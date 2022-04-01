// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      access_token: json['access_token'] as String?,
      refresh_token: json['refresh_token'] as String?,
      username: json['username'] as String?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      roles:
          (json['roles'] as List<String>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
      'username': instance.username,
      'fname': instance.fname,
      'lname': instance.lname,
      'roles': instance.roles,
    };
