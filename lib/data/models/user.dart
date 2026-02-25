import 'package:app_template/data/enums/user_gender.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final UserGender? gender;

  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
  });

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
  ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
