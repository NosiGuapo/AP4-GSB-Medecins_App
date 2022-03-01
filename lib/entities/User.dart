import 'Invitation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

// Useful : https://app.quicktype.io/

@JsonSerializable(explicitToJson: true)
class User {
  int id;
  String lname, fname, username, mail, passwd;
  DateTime? register;
  List<Invitation>? invitation;

  User({
    required this.id,
    required this.lname,
    required this.fname,
    required this.username,
    required this.mail,
    required this.passwd,
    this.register,
    // Invitation is optional
    this.invitation,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
