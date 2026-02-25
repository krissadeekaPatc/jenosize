import 'package:equatable/equatable.dart';
import 'package:jenosize/data/enums/user_gender.dart';
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
  final int? totalPoints;
  final bool? isMember;

  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.totalPoints,
    this.isMember,
  });

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
    totalPoints,
    isMember,
  ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    UserGender? gender,
    int? totalPoints,
    bool? isMember,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      totalPoints: totalPoints ?? this.totalPoints,
      isMember: isMember ?? this.isMember,
    );
  }
}
