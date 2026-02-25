import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth extends Equatable {
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expiredAt;

  const Auth({
    this.accessToken,
    this.refreshToken,
    this.expiredAt,
  });

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    expiredAt,
  ];

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}
