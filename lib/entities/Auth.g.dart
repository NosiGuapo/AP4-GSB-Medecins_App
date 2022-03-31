// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      username: json['username'] as String?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'username': instance.username,
      'fname': instance.fname,
      'lname': instance.lname,
    };
