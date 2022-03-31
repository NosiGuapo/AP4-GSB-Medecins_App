import 'package:json_annotation/json_annotation.dart';

part 'Auth.g.dart';

@JsonSerializable()
class Auth{
  @JsonKey()
  final String accessToken, refreshToken;
  final String? username, fname, lname;

  Auth({
    required this.accessToken,
    required this.refreshToken,
    this.username,
    this.fname,
    this.lname
  });

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}