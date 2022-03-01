import 'package:json_annotation/json_annotation.dart';

part 'Invitation.g.dart';

@JsonSerializable()
class Invitation {
  int id;
  String key;
  int maxuses, currentuses;
  DateTime creation;
  int owner;

  Invitation({
    required this.id,
    required this.key,
    required this.maxuses,
    required this.currentuses,
    required this.creation,
    required this.owner,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationToJson(this);
}
