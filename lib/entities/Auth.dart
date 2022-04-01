import 'package:json_annotation/json_annotation.dart';

part 'Auth.g.dart';

@JsonSerializable(explicitToJson: true)
class Auth{
  @JsonKey()
  final String? access_token, refresh_token, username, fname, lname;
  final List<String>? roles;

  Auth({
    this.access_token,
    this.refresh_token,
    this.username,
    this.fname,
    this.lname,
    this.roles
  });

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}